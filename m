Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3453264A9D;
	Fri,  7 Nov 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520765; cv=none; b=sj/8aoxFK9WggQo0sp4ktITSONQcxw0p3sZrDYjwEU5m3p2vNcrL2keRhe3U7aNHrIkkKg7BWrZhOEEYq5rgsC58xFgJdH4UFiDw1XX+wkmJ+ljsA7ctE90ZQTBjEm56a+hu0x6LjyssdS13wVzQco9LlLxvEMUjjCZIFVLHNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520765; c=relaxed/simple;
	bh=XDtcu17QGCoIj5ET6V+obMUewOA4S3RLNoGmmmP/ah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6F1CXLy/P8532FDulDuApbxU1FtoKcfv8g/Pbe+kEC8Nh2Rd1FTgBspc6unH5eQyAD7+F+fFnSwHIsrYxv6JlXnJzYzdwtSJSYmSQNh3nHmCQPKK/7MGyWIDzos8iLarST5eoG0KXAWLJuAAJejpoVQKdW8GXYdUFEuxzbPN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oegyogl7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oegyogl7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1t+/3tNlxJbaS0a5tJyCf+0ruItdJ6TWgFrzzhIErt0=; b=Oegyogl7j+TKN5sT3QZkkgJrBF
	ZJvnz/l6AyNmVI9ltY+f74nzrz5ONFakAeKq6LjTYahqCIi6wcj9GHaUgnyaRH8Cw1GyA/XkFtC4Z
	uK9vQoLrrO/C5D6yICt2f3chHXdL5JZPs9mJhhVuGp1Z8KkzsczAs5WYRsVF8FPeOvB9jawjE7DGK
	+oeTEJGq5bPhSArHAjkVXSv+bMtRFTwvXJYcUqZyOhzsQdMycdxYMLFJe77ylBUp2sneqO28TOs8f
	u7mzDXz8SmksZAs9W0nHPa9SGjry5H1HbMtFddem2i6AI0o/H0n0vOPEpDJswgYVktl5VKzaH7JPk
	d3+aoxDA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHLIO-00000006R76-0UT9;
	Fri, 07 Nov 2025 12:10:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 563DF3001D4; Fri, 07 Nov 2025 14:05:52 +0100 (CET)
Date: Fri, 7 Nov 2025 14:05:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>

On Fri, Nov 07, 2025 at 02:11:09PM +0800, Mi, Dapeng wrote:
> 
> On 11/6/2025 10:52 PM, Peter Zijlstra wrote:
> > On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
> >> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> >> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> >> should be dynamically configured base on these counter and precise
> >> distribution bitmap instead of defining them statically.
> >>
> >> Update event dyn_constraint base on PEBS event precise level.
> > What happened to this:
> >
> >   https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/
> 
> About the issue, Kan ever posted a patch to mitigate the risk, but it seems
> the patch is not merged yet.
> 
> https://lore.kernel.org/all/20250512175542.2000708-1-kan.liang@linux.intel.com/

IIUC the below is what is required handle this new dynamic case, right?

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5423,6 +5423,8 @@ enum dyn_constr_type {
 	DYN_CONSTR_BR_CNTR,
 	DYN_CONSTR_ACR_CNTR,
 	DYN_CONSTR_ACR_CAUSE,
+	DYN_CONSTR_PEBS,
+	DYN_CONSTR_PDIST,
 
 	DYN_CONSTR_MAX,
 };
@@ -5432,6 +5434,8 @@ static const char * const dyn_constr_typ
 	[DYN_CONSTR_BR_CNTR] = "a branch counter logging event",
 	[DYN_CONSTR_ACR_CNTR] = "an auto-counter reload event",
 	[DYN_CONSTR_ACR_CAUSE] = "an auto-counter reload cause event",
+	[DYN_CONSTR_PEBS] = "a PEBS event",
+	[DYN_CONSTR_PDIST] = "a PEBS PDIST event",
 };
 
 static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
@@ -5536,6 +5540,14 @@ static void intel_pmu_check_dyn_constr(s
 				continue;
 			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
 			break;
+		case DYN_CONSTR_PEBS:
+			if (x86_pmu.arch_pebs)
+				mask = hybrid(pmu, arch_pebs_cap).counters;
+			break;
+		case DYN_CONSTR_PDIST:
+			if (x86_pmu.arch_pebs)
+				mask = hybrid(pmu, arch_pebs_cap).pdists;
+			break;
 		default:
 			pr_warn("Unsupported dynamic constraint type %d\n", i);
 		}
