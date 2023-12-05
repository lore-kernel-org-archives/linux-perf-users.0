Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BA6FCC6
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="famdhsM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F9C433C7;
	Tue,  5 Dec 2023 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701813026;
	bh=VLI7kPveWbWwPgk7uPRYKi16eKz1FOlaDzT1BH/sKiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=famdhsM1YLcq2pCSZLqtoXfVPUfHCbzVp2dG801ncktsbcUY6cYXCOwvvjFSg1XaG
	 OrZqZuJ2e3ueGZWgmxhMjQW/vpFSO8rEUHERJws713+qCZ+m3n82ZPECtKdWJ+UVg+
	 Uv1S9q5Pk4OUU91lnSMfTm67o2cewixMQg7WB7GcALL7oSLifrO8aqU+UhjXIU1t4Z
	 I5chfcIJoP3ivgwiFDr9BFhpAI8UcHIh0zl5xx5MrmF/BYKKRNTkLvlcsjvbO+d3vj
	 /CV6+kOqLuUFcAZpPJcl+v+5bitQOil14M/WF43Zr37MOOXDqYcehnY+cOn0X1n0Ea
	 tQYfKnONW8Y2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 18C6F40094; Tue,  5 Dec 2023 18:50:24 -0300 (-03)
Date: Tue, 5 Dec 2023 18:50:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V4] tools/perf: Add perf binary dependent rule for
 shellcheck log in Makefile.perf
Message-ID: <ZW+bIGC3r2dcTQUO@kernel.org>
References: <20231123160232.94253-1-atrajeev@linux.vnet.ibm.com>
 <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8143e4d-d3ca-88c5-f1c8-b79f70ee5ffa@arm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 11:12:57AM +0000, James Clark escreveu:
> On 23/11/2023 16:02, Athira Rajeev wrote:
> > --- a/tools/perf/Makefile.perf
> > @@ -1134,6 +1152,7 @@ bpf-skel-clean:
> >  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
> >  
> >  clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
> > +	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
> >  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> >  	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
> >  	$(Q)$(RM) $(OUTPUT).config-detected

While merging perf-tools-next with torvalds/master I noticed that maybe
we better have the above added line as:

+   $(call QUIET_CLEAN, tests) $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean

No?

Anyway I'm merging as-is, but it just hit my eye while merging,

- Arnaldo
