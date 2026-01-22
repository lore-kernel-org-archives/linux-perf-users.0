Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D3A89DA;
	Thu, 22 Jan 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096047; cv=none; b=KlSyVCbAzbfzULc0GOA1ZfpH/+eWBL8YiXVYBZ/yQQuUHk2l2qjHwQajCDfdAAQNbP47fVK+Tue0tjP5CoOFuYC3A41VgyFTnDJhnb8IHeoGbMCxuWuySzt2Xz9zHsydXousITqe90SATnrP+WwWEPAuO22KxiC6BSyb46kqioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096047; c=relaxed/simple;
	bh=kMHVGmv01DltD3OLgHPDzKFvmDs8fmhc60zcH4zTeDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvrtzUqKdD6GkbFwbMuwYkH/PyD5aQaMEtXWbOwtXpBbfI/Uuu0HjQ4rfg+Nar2LBmzI/tuk/GeXPvcWMPb7oNSh63J8bYMUpq2R8FhwE62EJ3FdQ8rpsroMCZl5rVZldZ98wjtAikO22m0JYC7vFmJ+PTYrcVeKcyykvxfU5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsQeOuNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsQeOuNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B18C116C6;
	Thu, 22 Jan 2026 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096046;
	bh=kMHVGmv01DltD3OLgHPDzKFvmDs8fmhc60zcH4zTeDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsQeOuNGRITptjWK02z3x8FwAB6uwEuk0d9m9mD9W54M5w0iasB4QRafYg0pSAmFj
	 4cPNb9wg+gQNf0sloWzj9b9axDrFI4oHKNG1jQoulxuhj0brmpjRlib8XeSDmrgl2O
	 Ln2/x4mc6dPuYaYLPKWLja47KxRBL7h2U/LPDIkJLo3ct+siyOpivXSFohbPbyQ76T
	 uOgRO5FwODsc8g8QoKnpS73bS25tZLsr+ahADQnRxWK6NV/mPpTRA2t8tTodG/NyD+
	 HX3KRsHow2HXs7y0FPNtqjB8jEJYnRRolOrmnlYROg33iLbdCPbpeXCA/nLWU/zcTI
	 uHxi0GoOzKXhw==
Date: Thu, 22 Jan 2026 12:34:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
Message-ID: <aXJDa-peSknTnk9_@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <aXF1OECUByl0kgCF@x1>
 <aXF-RvjGU-mPA_B1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXF-RvjGU-mPA_B1@x1>

On Wed, Jan 21, 2026 at 10:32:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 21, 2026 at 09:54:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > So continuing to test build up to:
>  
> > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5
> > 139b45df27c05531 (HEAD -> perf-tools-next) perf sched stats: Add schedstat v17 support
> > e092c5d4541da7f0 perf sched stats: Add schedstat v16 support
> > e659d5e11000b7ff perf sched stats: Add record and rawdump support
> > 900884770020691c perf header: Support CPU DOMAIN relation info
> > a02829a0e6c65b12 tools/lib: Add list_is_first()
> > ⬢ [acme@toolbx perf-tools-next]$
 
> Just the first two patches build on 32-bit arches, I'll look at it
> tomorrow after some coffee, for now at least the first two are merged,
> to make some progress.

Its simple stuff like:

acme@five:~/git/perf-tools-next$ git diff
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f1051224124437c6..5a98c16e10923d57 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -599,7 +599,7 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
        size_t size = fprintf(fp, "\ndomain%u ", ds->domain);

 #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)          \
-       size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
+       size += fprintf(fp, "%" PRIu64 " ", (uint64_t)ds->_ver._name)

        if (version == 15) {
 #include <perf/schedstat-v15.h>
acme@five:~/git/perf-tools-next$

I'm fixing it here,

- Arnaldo
