Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D52214A9B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656311; cv=none; b=bNl2QV++8NyC129sQfsnXIrHDuxArGjf5ib2iC1pVTy448bOGftaCOg7PsDNdc2NZ9SMvh+G6yKWekMyOVxwPxIT+6/EM9F0afesLB4YGPa3pd8ClSnS+/sxlbDa5vFB3WmfkQa3tFaDrAf+3yhNMlz+q8APLmqA3yze3BeV0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656311; c=relaxed/simple;
	bh=7i6b0HQZmpItcoHiRjDWPxsI+KEN2RjAWI+wYkI2Gzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9OpVrdjGrS+KK7mqtAb3q9hLkS9/7BBeWQRG5DuVkHAdCLRpzytqEbyjIx0z4kh8IXTlI/tm/UiFwS9rosLg2U5RXo+/brw6fjAQeClNcquRRsQiIExbrljF+B2Sr+fZ4+19s6bn8L+vO+I9BtR87NyYyiiKuf0Nv6zMDMizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hooFbfX9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hooFbfX9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1506822b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 22:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757656309; x=1758261109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=hooFbfX9qGIPRouDdpxKBh+VC5sYTXZliz4PmWvxPCKl127AIagsLLtwPvzPQBXWHP
         s4ekyjZzE1pcGPnQ0s5HDN/8EHEH4Vm4cCTG6oPTDCBSuu2ZdF16Zq2IqYg2/iKHJ7nI
         4IwiiHRCcKEiujfc8bI18/8dED7qymMVGHMAHCFHcO5V3hIyrrE+dU/BGvOHbNYJsGHa
         WfHh4XrwKEWttPfNv5Nw9NE7cfEfvp/vXkwGzC/TdDX7emiY5122jLuF9EdigCoNkO8Y
         4Su5s+5Rl6OMi23xBHWUrE9UiE4W5DSA4YCBfNaQR1X0D04uRrqtGVobhP4cr32bOK4Z
         lNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757656309; x=1758261109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwxrf7orhL2KYO0iCZZdsGPUWyavjuMuxgjcqzj0tsA=;
        b=TZItD1SYNVRjWExU0L68JZCJrrvyLBFlmYoydOJDPJ/DXyeTiRG06hdRGzwcMDp2JC
         EdR7yMH8uSSuU7L0qHo/CRWMOxJ2tAtCarLXaC67ywHmqx333UjfPbKqqU8RsSsLUfXJ
         wEFvNyMXmFt0O3hIfVzRvjvFVAt8YNUnDwW+8GFSLb7PV3dds4Pbloj8DqbvdHuu6HPU
         Zcrrv+quXLbNcI0zxH8R0WfXVjbPEh4I5DngpaEWjNpDmRzbhcKpg/cGHd15Pgd93BBN
         Uli/cmUHjyfe14MUw2MRmxN5OTbJsUZjTSbsRzd3gy+VYhFhoiU2rp+QTgSvS2hG91uT
         3smA==
X-Forwarded-Encrypted: i=1; AJvYcCX5qMgZsaf+IL3u39OZw8SLZlSuRPAnJIbzYvmUTl4S2Um6f5z0I6GDPGaav98pSeUzLiCxFD8FYM8d2EY18Bdp@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGZ6UVyaI1WfVvJsxl+0KiLmtScn+XZsvKz5dMUfdvRTA5Ou4
	FOqN/HHv2btd5xRNpqi8aWEtQQcER2wPBN6QKUKgRK7QbInkz2NzxAK1
X-Gm-Gg: ASbGncu3/dtz6O7gRxu/Y1jCtFjJ3sN4VrGfN0aEl+TOAKysYyaaVVpzmb6ujleNEv8
	Di+ohpipy/5Q8Cz+53IoIm3DLnylumlLrVCMVR01nYWfUlsuX0HbIm61sOEpHESX/oOMxuvuMxU
	iOQLN4l/v0pqkJbxIlzoOvQaxjNeOy69mSazyJnzJ4ziGMBs1pRWKTSgWHOU9ECgZKOJd9A+4YV
	dcqPi3ckr+R3OOiOzbyL0tvbdisKyVTZGT1KbSNRzQuNyb3qhm7q3JMsU0ysX+IxNSqPJ0Ft7p8
	xevtCKhPx2mztV8VtzndGGCUpzqEFI/13XhgD7aObSeI/Dpga3mfBwK2gYnBv4MvmSKV9T10xpr
	yBsTkP5EvTj1nAKJgkFvrPI/cE0hKJPLTVKhOO/ww3tsGQQ==
X-Google-Smtp-Source: AGHT+IGzJaB63wIa8y1WxrhARLk2qyeDzg2l8cffF9pjyL26hVSSSTlaS01B7UHtSYXcq7zGWNVPeg==
X-Received: by 2002:a05:6a20:7f9c:b0:249:467e:ba68 with SMTP id adf61e73a8af0-2602c90cda4mr2342631637.50.1757656309414;
        Thu, 11 Sep 2025 22:51:49 -0700 (PDT)
Received: from localhost ([45.90.208.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761853866bsm450111b3a.95.2025.09.11.22.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:51:48 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:51:43 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
Message-ID: <aMO07xMDpDdDc1zm@mdev>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>

FYI: The current patchset contains lockdep issues due to the kprobe handler
running in NMI context. Please do not spend time reviewing this version.
Thanks.
-- 
Jinchao
