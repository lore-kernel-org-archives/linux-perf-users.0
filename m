Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB421A0B06;
	Wed,  9 Oct 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492673; cv=none; b=OpGIxs0bL9VVdiywhN55It8WIzj4eGQcBsQ/0Pczf+26AWCPOa+2TSqwitmREEHbIb9O5bcRvsaDQYxtMg5wc0D+/UvIR31NXlOWL6737IkVet1yc4BKWic5Dds+XRLSoTmH7lRPgmdVFEACTics5Cy3slW68xFOfAhDNnSqoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492673; c=relaxed/simple;
	bh=zXYuptHwSD5KhLZqOC39kgWtaJhrUCH3f46QqezNL3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi3oqM3Kb9k1fL+ijV437arAEhMJxhEhg3SanOiW0AwBLX43sfOVxuRXybNzmRQSB+BYJceHZanxMmins6XRRfTZ+c4rvkULPQO7/gednSSa0GQzytGqOFj8PEZrWLPtG85ZktJh/ESHvU6lVAZyVmHjlQmKttZBgSJCGvh2Mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BIinL4TE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BIinL4TE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=BToRIdU1VKAhz1U80/RKPLfu4q88jdl68InrtA5svGI=; b=BIinL4TEv4ovHhg0
	rO5+WrEJs/yPm6SDTNRuTHctMCTychpgYzt4mn13GbVeD203fjieHIC/YiB+sgo3p28CgmGwUKVD1
	t5UkNZajKRklZrTpGQftzBdV7G3QfSK+TGRO1soOl9xIUt0h+nWq9LeUbEuIGPMB5Tc4fi3j8tJwF
	J966NNbpb3GnfAWE32fQTnzRrAuxw0wyXJVHPXGD4zWrr5MC/3SRReNvchv38QwjLQomTGluln0Mg
	LHM3GxiH+SSirUUBH8L/Dc/IK1jT4VpxtawquDVtaY15pPsHIyjX5saFfHgEx0BwXUg0YED47oaBd
	v4JYjFgVgEvNgM9rpg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1syZtl-00A29p-21;
	Wed, 09 Oct 2024 16:50:53 +0000
Date: Wed, 9 Oct 2024 16:50:53 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH] perf callchain: Remove unused callchain_branch_counts
Message-ID: <Zwa0bfGAaBGTdD33@gallifrey>
References: <20241006012204.373803-1-linux@treblig.org>
 <ZwYVCTsf8p3v22HQ@google.com>
 <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:47:58 up 154 days,  4:02,  1 user,  load average: 0.07, 0.06,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Liang, Kan (kan.liang@linux.intel.com) wrote:
> 
> 
> On 2024-10-09 1:30 a.m., Namhyung Kim wrote:
> > On Sun, Oct 06, 2024 at 02:22:04AM +0100, linux@treblig.org wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>
> >> callchain_branch_counts() was added in 2016 by commit
> >> 3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
> >> but unused.
> 
> It seems the original patchset was not well organized. This function is
> actually used by the last patch of the series.
> https://lore.kernel.org/lkml/1477876794-30749-7-git-send-email-yao.jin@linux.intel.com/
> 
> But for some reason, the last patch was not merged. I think Andi gave
> the Acked-by for the whole series. It might be just accidentally missed.

OK, that'll be the 4th time this deadcode series has found missing calls
to functions!

> I think the missed feature is still useful.
> We will redo the test and re-post it.

OK, great.

Dave

> Thanks,
> Kan
> 
> >>
> >> Remove it and it's helpers.
> > 
> > Kan, are you ok with this?
> > 
> > Thanks,
> > Namhyung
> > 
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >> ---
> >>  tools/perf/util/callchain.c | 71 -------------------------------------
> >>  tools/perf/util/callchain.h |  4 ---
> >>  2 files changed, 75 deletions(-)
> >>
> >> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> >> index 0c7564747a14..11435b72afbe 100644
> >> --- a/tools/perf/util/callchain.c
> >> +++ b/tools/perf/util/callchain.c
> >> @@ -1266,77 +1266,6 @@ int callchain_node__fprintf_value(struct callchain_node *node,
> >>  	return 0;
> >>  }
> >>  
> >> -static void callchain_counts_value(struct callchain_node *node,
> >> -				   u64 *branch_count, u64 *predicted_count,
> >> -				   u64 *abort_count, u64 *cycles_count)
> >> -{
> >> -	struct callchain_list *clist;
> >> -
> >> -	list_for_each_entry(clist, &node->val, list) {
> >> -		if (branch_count)
> >> -			*branch_count += clist->branch_count;
> >> -
> >> -		if (predicted_count)
> >> -			*predicted_count += clist->predicted_count;
> >> -
> >> -		if (abort_count)
> >> -			*abort_count += clist->abort_count;
> >> -
> >> -		if (cycles_count)
> >> -			*cycles_count += clist->cycles_count;
> >> -	}
> >> -}
> >> -
> >> -static int callchain_node_branch_counts_cumul(struct callchain_node *node,
> >> -					      u64 *branch_count,
> >> -					      u64 *predicted_count,
> >> -					      u64 *abort_count,
> >> -					      u64 *cycles_count)
> >> -{
> >> -	struct callchain_node *child;
> >> -	struct rb_node *n;
> >> -
> >> -	n = rb_first(&node->rb_root_in);
> >> -	while (n) {
> >> -		child = rb_entry(n, struct callchain_node, rb_node_in);
> >> -		n = rb_next(n);
> >> -
> >> -		callchain_node_branch_counts_cumul(child, branch_count,
> >> -						   predicted_count,
> >> -						   abort_count,
> >> -						   cycles_count);
> >> -
> >> -		callchain_counts_value(child, branch_count,
> >> -				       predicted_count, abort_count,
> >> -				       cycles_count);
> >> -	}
> >> -
> >> -	return 0;
> >> -}
> >> -
> >> -int callchain_branch_counts(struct callchain_root *root,
> >> -			    u64 *branch_count, u64 *predicted_count,
> >> -			    u64 *abort_count, u64 *cycles_count)
> >> -{
> >> -	if (branch_count)
> >> -		*branch_count = 0;
> >> -
> >> -	if (predicted_count)
> >> -		*predicted_count = 0;
> >> -
> >> -	if (abort_count)
> >> -		*abort_count = 0;
> >> -
> >> -	if (cycles_count)
> >> -		*cycles_count = 0;
> >> -
> >> -	return callchain_node_branch_counts_cumul(&root->node,
> >> -						  branch_count,
> >> -						  predicted_count,
> >> -						  abort_count,
> >> -						  cycles_count);
> >> -}
> >> -
> >>  static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
> >>  {
> >>  	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
> >> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> >> index 86ed9e4d04f9..d7741fa9e9de 100644
> >> --- a/tools/perf/util/callchain.h
> >> +++ b/tools/perf/util/callchain.h
> >> @@ -298,10 +298,6 @@ void free_callchain(struct callchain_root *root);
> >>  void decay_callchain(struct callchain_root *root);
> >>  int callchain_node__make_parent_list(struct callchain_node *node);
> >>  
> >> -int callchain_branch_counts(struct callchain_root *root,
> >> -			    u64 *branch_count, u64 *predicted_count,
> >> -			    u64 *abort_count, u64 *cycles_count);
> >> -
> >>  void callchain_param_setup(u64 sample_type, const char *arch);
> >>  
> >>  bool callchain_cnode_matched(struct callchain_node *base_cnode,
> >> -- 
> >> 2.46.2
> >>
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
