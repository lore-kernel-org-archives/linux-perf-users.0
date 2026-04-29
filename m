Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB53FFAA3
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502470; cv=none; b=WYHGcVL46PEF0yBraxuDbjem/HQ4/f7+PuoTPPprm6nbWcLpUbzZ86ub7OZaSQJ+VG1zC8BK7gYNOc4eVs+i2HekcuBLTMK/C9egp12H33nD5YmBPH34nAuoedq2mtTgAoE2l+WV5LJbgrHSGS9SpsQ040VCeQ9UIEPSSiBiwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502470; c=relaxed/simple;
	bh=mjUGtz3RQ1FKasUue9EZj4wEEmsaMFd8EmS7brNXlDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKa1E/g+EkUf/stZVwmeXv7WlgiDNVRROgT5QXX6j3V+e0+wW3hIDn18O0WuAtoZoRRz7+dMvPKIgysCSMI6JRzig4icH1Pa7JRR76mrfyMUuEuUJbxPuyPEnGWr4un4RHtPm5j85roJRK1MWVxH0pe83SgmnD3LYu2gqQpOiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=P1puJC4O; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="P1puJC4O"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d868d014a5so355340eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777502468; x=1778107268; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mjUGtz3RQ1FKasUue9EZj4wEEmsaMFd8EmS7brNXlDk=;
        b=P1puJC4OiOCp1eMdqcdOkMIRvYcbtya+efbaHtv9FCd7sidrqIh6Zu8wcQzfF4a1w+
         6Z9lNkCzeHXco11J38upMt6iU4YvVjs4VQ2Bb0x+WH2DcE5/eMJn9HjaDZrdigwbmcLD
         iJ4jFrKQrt4WCAwTXLEhuZsoLB34EZnEkyB84WFSFS+bR5JBMJpYyMFkTQH1raPibbL3
         BAP3ElemzXA65UMivfcdZpdqbevoSsENLRIeic9QTxU+9YUn0oJshOYRUviIGwDj/nTF
         Byc9PBgSOC9ku0XWRg//Cn11kZ/Lb69ZNCTWX3ht8HC5byESGu9s3dPKMbAy9WVZdvuN
         XoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502468; x=1778107268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjUGtz3RQ1FKasUue9EZj4wEEmsaMFd8EmS7brNXlDk=;
        b=kYSElnCAXG/WVf3Uw5iGfay4sV9ECcihYO3dE9CNcHfYrue/p4hQQYO27mVX8Nz/Pr
         bVmRkhFCqAMGLJ69XlHte7c6PIo/tcIGaVA4z7egWoTLyrgArHMNUKMQzx8HmN9MNfd+
         HArps+JqF976XtLd7l2sUWsHb2JtEmmQydnP+xng9wRUVg9kpbKB018T/JH3oejNwRqI
         IAzBh7yzQMwZiAhf+ss790Grq8Xjgn9ou/9xHwmHFt3ClYPXx8yblEBd9BAgr51WXiFH
         T3dgP1/QCRbOP0bLBXQNKFJwj/08kql8VKxlMrbJCwSMH9Tro3Ip21K+6vu/KpzVR6G/
         jEmg==
X-Forwarded-Encrypted: i=1; AFNElJ/oyFjOeC9VsXpdNlcitO5pFsPRsNQIoTu7BH+G0zNsEpcejLoOXONyIiOdHgsj8AJl5czta6JUO9P+hY0RHKTR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkt3f8dZ5ZgjyeOuSpyGOQrjAl6nIUcaWL2tqmpKI2x7kXVvUw
	fEbKqACLWZwmviP4rcdZNGOQ0nRJX1071DeITXSDVPC+H5HOzUorxlrX8iasb6qqo5E=
X-Gm-Gg: AeBDieseOG5222Ciw6CMj3MdeSgqDAdigwy8Uo8n5i3KKX2wA/O1HhYnVTx7BrChHtx
	Tpj5Ck1JTC4SXmnFAkhOaeB5eOK/45oMbXHoJQInSX69aoX24SiptpXKUVQrP5OOmHNpYSeSssw
	s/g0XAFSU6Q+JZxjJ5tFj7p1iZaRbG3GiyTzFfG6DCKOeUpE6JK0f6UZsVSAZ8DDDS5RHDAJMsE
	aKyt9EKNqiRJd6EtU29ky8qLzuiMlNz95uvO/SNtCSITK5M6y7rsGwoU7Yxd88DX0MSPZau5IjX
	CGR8MLBaX2yF6nvEQOTbTsVayhhx4rwvAt2+yuMh5qmXuepk5QOwlitaE4eZjZiaHpVM3R4KVI7
	cnhEIUJZpdTb5GLLxbreYp6cYW1y0A9RdSk/79JzJvGywCG4YbO7DpYOeeHsSN/y0KJFlz2jyKV
	NpXG6LJrG+MzgIn3aBOVe5IcwcP3FkkEG/t4iF
X-Received: by 2002:a05:7301:5809:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-2ed3e486e38mr100596eec.18.1777502467521;
        Wed, 29 Apr 2026 15:41:07 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:e0e9:7085:c58e:926d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm4085360eec.27.2026.04.29.15.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:41:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:41:04 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog events
Message-ID: <afKJAJpbEFFyhgnQ@mozart.vkv.me>
References: <cover.1777483573.git.calvin@wbinvd.org>
 <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
 <afKBd87b4AKbCYuL@mozart.vkv.me>
 <CAP-5=fU14AN8XA5CMWGpi0=9wDV7Ev3AA=ouO2DhA5AHH2wU2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU14AN8XA5CMWGpi0=9wDV7Ev3AA=ouO2DhA5AHH2wU2g@mail.gmail.com>

On Wednesday 04/29 at 15:15 -0700, Ian Rogers wrote:
> On Wed, Apr 29, 2026 at 3:09 PM Calvin Owens <calvin@wbinvd.org> wrote:
> > On Wednesday 04/29 at 20:38 +0000, sashiko-bot@kernel.org wrote:
> > > Additionally, is it possible for user-defined PMU events with expensive
> > > overhead (like heavy eBPF programs attached to slow tracepoints) to exploit
> > > this hardcoded frequency bypass?
> >
> > No, I don't think ebpf programs run in NMI context?
>
> Unfortunately Sashiko isn't currently reading replied emails, but you
> could copy-paste this feedback into an AI.

I know it doesn't reply. I was hoping for input from somebody who knew,
more automated guessing from more LLMs is not really helpful at all :)

> BPF programs can run in the NMI context, which means they can
> introduce delays. I'm not familiar with all the side-effects of and
> restrictions on this.

Thanks for the clarification.

Thinking about it more: it seems to me that if they run from NMIs and
their runtime is unbounded, this is just a consequence of that and not a
new problem. If they are somehow bounded, then this must be bounded in
the same way.

Either way, I don't think it's a real problem as far as this patch goes.
But maybe I'm not being imaginative enough.

Thanks,
Calvin
