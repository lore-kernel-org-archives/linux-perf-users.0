Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFA2314D15
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Jul 2026 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266284; cv=none; b=j/dfFuGElPC7AR7pmMuDfSRA7012TtTCI4HtYRI11MYre8z8Xpb1XkqltdoN4GHpwbE+XIDwZWBgrOOUQswpjKNWjqZK3dyRrfiKISpJYiTf53Yj7iRkM+SFj2AE5kRPMWb7/HPlpyBRKEKhqcxpWiX9W7A5AbYOuNUb0mZbrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266284; c=relaxed/simple;
	bh=fQRjZa+S6Xi4bdBWEAt7FeBg9kKZ3+ndjEKF5cmPHI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDSNVEo5BHiMfpHR+HgLXePBpdWvSKkMGBg4TkaV69j6ZBHPlktwxs3lyMG0LpjxArzpEXCT5S8kVWwSszgudC5qpqAKaaet2HzOYjhxssh6p3mVvgedkINpTq+5y2EvDOBM163vtmdKBFrCIFYlZcRFXenoquFH+QdCwFA5Rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FuaHMpLN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FuaHMpLN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9676E1D6F;
	Sun,  5 Jul 2026 08:44:36 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880F83F85F;
	Sun,  5 Jul 2026 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783266280; bh=fQRjZa+S6Xi4bdBWEAt7FeBg9kKZ3+ndjEKF5cmPHI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuaHMpLNu43wurjTvtxwwOOHAXtbuv6ityFN4KpZ96sYeTxyVgh7SUBsMrHrNgsIz
	 BeY6TEBFeo0INWLRxcBlM/yUgRiQpSHbp1CQgW2elJbs/jlWAEdWpianencZSbKkfN
	 IsrqB0VbIH5z59QsRNV7UUp3uh6FTVCzVb9Oqh9I=
Date: Sun, 5 Jul 2026 16:44:38 +0100
From: Leo Yan <leo.yan@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 3/5] perf/arm-cmn: Refactor event filter data
Message-ID: <20260705154438.GA710301@e132581.arm.com>
References: <cover.1782830759.git.robin.murphy@arm.com>
 <d638212f5a5993eae5e262dd5be596b8d2b8fa5f.1782830759.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d638212f5a5993eae5e262dd5be596b8d2b8fa5f.1782830759.git.robin.murphy@arm.com>

On Tue, Jun 30, 2026 at 04:19:18PM +0100, Robin Murphy wrote:

[...]

> +struct arm_cmn_filter_attr {
> +	enum cmn_filter_select sel;
> +	u8 val;
> +};

> -#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, _fsel)\
> +#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, ...)	\
>  	(&((struct arm_cmn_event_attr[]) {{				\
>  		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
>  		.model = _model,					\
>  		.type = _type,						\
>  		.eventid = _eventid,					\
> -		.filter = _filter,					\
> -		.fsel = _fsel,						\
> +		.filter = {{_filter}},					\

This patch might break as the "val" field is never initialized. Should
it use two parameters "_fa, _fb" instead?

#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _fa, _fb, ...) \
      (&((struct arm_cmn_event_attr[]) {{                              \
              ...                                                      \
              .filter = {{_fa, _fb}},                                  \

Although the issue is fixed by a later patch, I think it is good to
correct this patch for bisection.

Thanks,
Leo
