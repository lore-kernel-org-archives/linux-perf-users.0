Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434806;
	b=YIHC0x311PrfBTrEAGLmcFYUxauRfcY0fBSOE4RkNofX1tYLQr6XxKxqtUlOOBzvpAnB
	 FDLUk8I7QS47cN/ArD4b6PFPdmv+jwurtrq1R4dnDuLJ3W0zZWlVvgZW3LVUUyEIiejLz
	 hHG9LkUPXeVrJihd/fZVqNfsJGAmvHomos52hFksDu1oUnNiLgQI9QnduQyt1hD4hrCv0
	 z3tG8jCfpdx6v3obkhPVUsRGOK1eun6DEgenMVwJPQrZ6oigBnB2R7wq9AANNVA5Tisgl
	 4013wycmrsWwS7AiAEnResvoERGkmGMk6gSHrPazR9r0GdWQdYM0xmRBC0OK/y8MYbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434806;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=XvzEmeTIxXyutq1PXClFF3+A3A4QaLFL8E1yjF/uOVM=;
	b=KmccM61sJy3sNTjW8NKuhKcjFslikC7cg0RFuUdwCE/xUUYdp9aGxi2CwfZ0vq1yGgXB
	 K8wQ7iw7uiUoIHTft+cw+yGWmklSYUhEx+YA7d6NbAlwnAcQ4jPc2DblZN/OLwWoK2bUl
	 KKYLqNP1sXEwy+oScFMqQqB1c/6KRBKFSeTIscT+o3o1A03AbvwsIA28Q5VZysH4/gWRG
	 w+POUTzPOQ0P9EJnkgKp1dTduC4255IHEW9mhVKiuJo0EvN33/VeqmBTvGSMQaI5Y/iGZ
	 UoYfs5ESBJF5c2Rix5ajGKrWrWGhAxy7WDGODClukRKZOVorQnpQ3IDeQWMD2/Li3fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qt75YU3b;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F2606A31A;
	Mon, 23 Nov 2026 11:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qt75YU3b
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32098143D;
	Mon, 23 Nov 2026 03:53:22 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0AEC3F882;
	Mon, 23 Nov 2026 03:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795434805; bh=RYiIfxkDaSmX84xLMRyq6/NcK2Xs3/5CbbES0suYhVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qt75YU3b9IX1teTA93OzvDq6X7Oe3ZnyDyVLUjwaAHC4X7Nb36+f9OfXtVZiu6E8N
	 QyrHjBzaMwPjmpSIc+kKHmbJ7YcOKGgyW8B0UiNQRSz6JKof8vAkU+dwT7fr04Xi78
	 Q8GmkPvA7o5KPkoovCNy2agd85FsSuoCiSVEi2Vo=
Date: Mon, 23 Nov 2026 11:53:22 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/25] coresight: perf: End AUX output when an event is
 throttled
Message-ID: <20261123115322.GC9176@e132581.arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-4-35cf6f297d20@arm.com>
 <5b94b79b-8c4c-433d-8c9c-d92b4a8399c5@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b94b79b-8c4c-433d-8c9c-d92b4a8399c5@arm.com>

On Mon, Nov 23, 2026 at 11:01:04AM +0000, Suzuki K Poulose wrote:

[...]

> > @@ -748,13 +748,16 @@ static void etm_event_stop(struct perf_event *event, int mode)
> >   	 * handle due to lack of buffer space), we don't
> >   	 * have to do anything here.
> >   	 */
> > -	if (handle->event && (mode & PERF_EF_UPDATE)) {
> > +	if (!handle->event)
> > +		goto out;
> > +
> > +	if (mode & PERF_EF_UPDATE) {
> >   		if (WARN_ON_ONCE(handle->event != event))
> > -			return;
> > +			goto out;
> 
> We seem to be disabling the path in this case, which is a new side
> effect ? Do we want this ?

Yes, it is intentional to disable path for this case. By this point,
the source has already been disabled and the event marked stopped,
so I intend to complete teardown of the whole path.

> Also, could we not move this out of the if condition ?

I initially left the check in its existing position to keep the
validation changes together in patch 05, which reworks the AUX-state
checks with perf_get_aux().

I can update condition check like:

  if (!handle->event || WARN_ON_ONCE(handle->event != event))
      goto out;

If this is okay for you, I will update patch and send out.

Thanks,
Leo
