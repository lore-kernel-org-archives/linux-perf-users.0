Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CE36B00
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGXNuiVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C524BC433C7;
	Wed, 18 Oct 2023 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697637600;
	bh=AtI6WN6MCmXImGsH4lHprkwWGESmRD0mReaxYBg6ro8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGXNuiVgjQWxKsBsoRsOUjSoI6HX1valda+YWLbbxXCieQXrWv0HZAcbWWhJ5i7Rt
	 kPSRn50KsSyhrSlD5Uf+eM++FAZli6dEkDjcf21Tulu+M9/Hm/MyJo/FRiO3HUTpcS
	 5wStN/WOHGoOgUVvN1be2CR8yHNClpeZnGujk9aOUPEnDn/31PW54DPJtooHZP/jXf
	 MdWz2/5Q99wsLdR1od6zmetrgHGGTzIPt5sPeBdUNLYD+3gnqmGdeUyECL50s7tNr6
	 qfEXRoEuSwOt6T68vgQmJFe73AL2/lTQmZpLGjYg8iFtygiSi17GW9PsnmM20P1oIH
	 8k8e6dJw4IJ0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D0DAD40016; Wed, 18 Oct 2023 10:59:56 -0300 (-03)
Date: Wed, 18 Oct 2023 10:59:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, linux-perf-users@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, robert.richter@amd.com
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
Message-ID: <ZS/k3CSP1g3T27NG@kernel.org>
References: <ZS0l-k1MASK3547Q@gentoo.org>
 <ZS2vu8bSBS1/zseZ@kernel.org>
 <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com>
 <ZS6Ds+rB2IwWmXML@kernel.org>
 <f48256a1-d165-de5b-06e8-29646218955a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48256a1-d165-de5b-06e8-29646218955a@amd.com>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 18, 2023 at 09:29:01AM +0530, Ravi Bangoria escreveu:
> > Do you think we can detect that it is a zen2 processor, that it has this
> > problem, and then the tools can just avoid using precise_ip != 0? I.e.
> > "cycles:P" becomes plain "cycles" and asking for, say, "cycles:p" states
> > that this isn't possible on Zen2?
> 
> It's possible, but there is no architected way to detect Zen revision 🙁. I
> will need to key off based on Family and Model checks, which is ugly. Also,
> the same problem can happen if user invokes IBS pmus directly.
> 
> >>> [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
> >>> # cpu pmu capabilities: max_precise=0
> > ...
> > If we can programatically detect that IBS is present we can add a note
> > right after that 'perf report --header-only' line with this information.
> 
> This should be easy to implement.

Yeah, I took at stab at it, see the patch below:

[root@five ~]# perf report --header-only | grep "cpu pmu" -A1
# cpu pmu capabilities: max_precise=0
# AMD systems will use ibs_op PMU for some precise events, e.g.: cycles:p, see the 'perf report' man page for further details.
[root@five ~]#
 
> >> Unlike Intel PEBS which provides levels of precision, AMD core pmu is
> >> inherently non-precise and IBS is inherently precise. So max_precise value
> >> is irrelevant for IBS. I mean ibs_op//, ibs_op//p, ibs_op//pp and
> >> ibs_op//ppp are all same.
> > 
> > This part can go to the man page, where :p, :P is documented.
> 
> Sure. Let me prepare a patch.

Great!

- Arnaldo

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 44140b7f596a3f20..cbc18b22ace5231e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -531,6 +531,24 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
 
+bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name)
+{
+	char *pmu_mapping = env->pmu_mappings, *colon;
+
+	for (int i = 0; i < env->nr_pmu_mappings; ++i) {
+		if (strtoul(pmu_mapping, &colon, 0) == ULONG_MAX || *colon != ':')
+			goto out_error;
+
+		pmu_mapping = colon + 1;
+		if (strcmp(pmu_mapping, pmu_name) == 0)
+			return true;
+
+		pmu_mapping += strlen(pmu_mapping) + 1;
+	}
+out_error:
+	return false;
+}
+
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd956ca..56aea562c61b750d 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -174,4 +174,6 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap);
+
+bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e86b9439ffee054a..faa1f67777e6a88e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2145,6 +2145,14 @@ static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
+
+	if (strcmp(perf_env__arch(&ff->ph->env), "x86") == 0 &&
+	    perf_env__has_pmu_mapping(&ff->ph->env, "ibs_op")) {
+		char *max_precise = perf_env__find_pmu_cap(&ff->ph->env, "cpu", "max_precise");
+
+		if (max_precise != NULL && atoi(max_precise) == 0)
+			fprintf(fp, "# AMD systems will use ibs_op PMU for some precise events, e.g.: cycles:p, see the 'perf report' man page for further details.\n");
+	}
 }
 
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
