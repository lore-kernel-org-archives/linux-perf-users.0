Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8B13CFBC;
	Wed, 26 Jun 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410266; cv=none; b=HtWEBBcIr66dTIAQZNPiykyLzp64e8aO6bBEYyRmtlTYzhPopV9cAnUR/BMBKkbDRL2chvx3dSkVYJrwbTTf3Q1Wgu7KpNl3NxAlQioaXhn69SSO+y4Cgbb6qoM2Se4cO8C763yrQTDiWUz5qAWh7vsuqUiyG82+nXBDtHPZ8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410266; c=relaxed/simple;
	bh=wTAlYD8QImoqPDkhp/cj1S+EMs3bvaRrPWlHwbQp7dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z96nZ27VVK/7Cx8ghnJ4qRVk9kznq+KMBGjrkUMwvcywxIWjShPWIY50Km4YbAcF85ax+J4s9qZVwy0LKIeeVHyaU9lEY0I2WUE65fM/aX0jjmM5hsquTOXg1ZEPBtReBlM+YgZkOd81tBHVYO7xY5JSJG2Q7HrBvK1v+LVt3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so356529a12.2;
        Wed, 26 Jun 2024 06:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410263; x=1720015063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLsCyunUMFV0UFP/6cGb0jTp7IysuDFJZXn6fTsqWSY=;
        b=jmmXei6OzgjIPUSBG3KfPz87F7U1wABtny2Go0qUwFPPvIZ7ohQwGsR8GDW8sVaDfT
         Fvq/5e8SmkdBnzL579UAzoK7lIghMbiQPuDmn8g3zfVL3PI69eZJp81u4i7RSw3PUjZd
         vqTRKz+1bhgE4lrWGODQ8NoFLcC2DmncJvAMAI82+NKEGLCR4pGKmR6ai12u37U9SU/V
         eDPX8n/4kEr3gzEuhX2Eu6rQP4zLUixCHwJawR6/8YwMJoYzdQCc7XNYUs0op/33wes8
         CXR2QgtPaY32BiBsbfl5kIpn3m8+3xPbywd2F7zTA1e8QNhbreCoiyGwBw7QZUZAEZLq
         m9jg==
X-Forwarded-Encrypted: i=1; AJvYcCUPtP+6PNnWDy4aR23bp76BZH5zXWG0wCfG1fsVkafS8vpSQjtbzXB2AwGvL/qmbrFSf7FpLmZEskCMePiTkwUiVtW8jVOCfuC2hqy10xbirJKfysku2VMwqVyHi2d8zVMVXTYS7+tBz0Oi4JI6aw==
X-Gm-Message-State: AOJu0YxERYqebxawKAFjhEMzSmIRVfxhdTtRTGTUst5jyqvwU8mQTOX1
	BCHuC3APFXLCmpnLcxasDUn+V0HTAgTt+zO1k7Sm19iDvE+Zdfx2
X-Google-Smtp-Source: AGHT+IGxvp5hQRrv2XUQddKcmNAPMp7+0mzlWb9Q7XqS72h7gA6vRQ5q4c+VSvI2cTpbGT6CK6VNvg==
X-Received: by 2002:a50:99de:0:b0:57c:fa44:7a04 with SMTP id 4fb4d7f45d1cf-57d4580b070mr8351763a12.39.1719410263256;
        Wed, 26 Jun 2024 06:57:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d10csm7346171a12.40.2024.06.26.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:57:42 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:57:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, sandipan.das@amd.com,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Warn only on new bits set
Message-ID: <ZnweVM7qGvNDThV8@gmail.com>
References: <20240524141021.3889002-1-leitao@debian.org>
 <20240625115734.GX31592@noisy.programming.kicks-ass.net>
 <e17a924d-9699-465f-8bef-cde4411e2146@paulmck-laptop>
 <20240626085153.GA31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626085153.GA31592@noisy.programming.kicks-ass.net>

Hello Peter,

On Wed, Jun 26, 2024 at 10:51:53AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2024 at 07:47:06AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2024 at 01:57:34PM +0200, Peter Zijlstra wrote:

> > > Why not just a WARN_ON_ONCE() instead? This really shouldn't be
> > > happening in the first place.

> > We did consider that, but seeing the full set of bits that shouldn't
> > have been happening in the first place helps with debuggging.
> > 
> > But is there a better way to accumulate and print the full set of
> > unexpected bits?

> Dunno, I was just wondering if the whole thing wasn't massive overkill.
> The changelog wasn't really explaining much here.

I can help with some motivation, if it helps.

	1) This problem happens on random machines, rarely

	2) When this problem happens, there is a flood warnings,
	   sometimes it causes the whole machine to be unusable.

	3) It is hard to figure out what is the root cause, and to
	   reproduce the problem.

	4) There isn't information about what bits are being leaked.

That said, this patch will help with the following issues:

	1) It will tell us which bits are being set, so, it is easy to
	   communicate it back to vendor, and to do a root-cause analyzes.

	2) It avoid the machine to be unusable, because, worst case
	   scenario, we get less than 60 WARNs.
