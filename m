Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179C28CF56
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913676; cv=none; b=ZzGa/nBjsviSDOYBeQibGSujhuDVuI/TcM/NeDBA4sl/HScAdXvA1kFVqsRdowVM3xyx9tit/afw6N8E1FJ2pcKHeCm7I1WwPN+fGmN6Nqn/AaD/l13xl667mLA1bZ4r1T3eQtX/IQWheVXXVEgnNAvfYKF5brYBc7GmdLpUqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913676; c=relaxed/simple;
	bh=xwFVvgtw9uBd2ORKsLl6UhYsiyXLrRfI/zUbkQg0RWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Lp7zUJlLazX3LLYMW+JWfpGPd+a90tcdISKQ+l2vo7DHWeoWytXQalOFkERpw/i+xpH72oIfTjVe/YSNcxrHEJXpaG4caO+STC/gUB79B1eVTdexRE0hdn2C3Usqmz7Xi9QtfQHFCt0iBOclAwtlVwL2xc4B/n2I3avmH2gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuauiSLE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuauiSLE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34381ec9197so376825a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762913674; x=1763518474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVQBcx6xFjlJyhg8EGvnzlqkKD9tleq1IsOwgdEnnOg=;
        b=fuauiSLEBn9GiFcz5fEHg//fVQUy7nVf9NOyhSGqdw78w0KZF7cXP23cqhWiWVs2IH
         1M7qQ8Q8T0l758X2shuAsdXj7hHQ2xbwdsr7Rikwu0cEAPJQU+ku9XyT86rA/2U8JqAW
         6sS/u+ePsgpCAZS5Z8lbkgAwyfxIaXOKE6egbPGrWjzZbOcZdnKTR+nC9fcc2UwNdVs4
         m2jzFR9MPNnWRXsT9+ijW44d5VH7NfM9awbEWhyL6r/NFuJBFLvUnRcw7bMLOSxTwaEF
         rLDu9Ld+y6vZSR5p38zvNUqiNs3vSQlasopGQVnq/AVn7AFRXoFzszxPTXaGj5hipLuN
         VwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762913674; x=1763518474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVQBcx6xFjlJyhg8EGvnzlqkKD9tleq1IsOwgdEnnOg=;
        b=cdZzQJEEQZnmyqHn/f4cAoYV5F9Hxf91CVZbSINPb200eUT/sXcpOEILTEPetYgMor
         pqR1EC87jgAXcXO0HEnPiapEyUel9YhWbCGnXOjXsRT9i7vRd4OUtZDpA8CZOHEjJ5vn
         hGbJfHS0Xos/+YoQVriQx1JEbutMHd69Df4jfV3foVg1eFk51FhOfTnIpotazQTwjvVT
         0Su85GQBrLPKWIuj8ck13DDdQDaOoTbet1h/5US3gtFJL1OfrnqQZNOH1+wgT/DRs0aX
         dgLenXFkPn50G0BhjRKyYRBn3/pB6iNtoljch9rRf1FLx2eT6X8L9ZZ2c9QZFFYqtsmQ
         QzQg==
X-Forwarded-Encrypted: i=1; AJvYcCXCUjD3AMoWSU/mdukt2B3HJOIwISSwLnSiNrau3TfO79lAeXkgmQcnCJApGYvDJUAHobxDJoGWnEvhSMaPd/xA@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtB8lQCKFBYuOr8JDXTV/pU/J5yXjNdg0FUwPbvJlYxNDxgDF
	EbEJPgIJACg6PON51bM5iLDtQ3g4IH72smy2og08gFBFilrpO20zk4gd
X-Gm-Gg: ASbGnctumGNtPGqM5bmHVwja3yEHNIOu5nD3V9isvZ8JHjZSO76RG3htym2szcsK5Jl
	Ovv6WtS+s+Lyt3qBpLj7fcg4GWeT2n/spn8I+ZnReS/nSB0YBVXfnobAtvgYPwPM2cb7zCpyeTu
	QfzgUxMtR8yxztq4fire/Gq01iCjIsCQwRWCq17VMOOe3tLvecjNXpslQwO8bHe9DHq7TYmcwsp
	xC5rbDxco0eL/6bERNYMtE3muUQ7vr6QAP3sIK+ZKKQD9MIal77Sj5ek/9OzaZWHSPQFsJ2zuZJ
	l2+OvFeWBk+8KMeRJ+9QbAOydS4eXLF4o0vpl016KqcIosOsvuHRcb3EKt0MOTPr081TpB9VVnu
	r9zszfr53MhyS+n1GXJzhLS06UBYt2CmsQfmIT1UyiapX77k/6Wd7QNIWdBV55+gXWbq29lMCt2
	lUU98YJvvxr2k=
X-Google-Smtp-Source: AGHT+IFqj6mSlRUdzokZ1Fx9dnl2ksqvuqBqsXipooXRvbblexf8W6duI6LZnIuMeBzrfzf2MAr1ZQ==
X-Received: by 2002:a17:90b:1b0c:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-343dddf6caemr2117777a91.9.1762913673519;
        Tue, 11 Nov 2025 18:14:33 -0800 (PST)
Received: from localhost ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e0714267sm559591a91.6.2025.11.11.18.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 18:14:32 -0800 (PST)
Date: Wed, 12 Nov 2025 10:14:29 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>, kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>, Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRLmGxKVvfl5N792@ndev>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
 <aRIh4pBs7KCDhQOp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRIh4pBs7KCDhQOp@casper.infradead.org>

On Mon, Nov 10, 2025 at 05:33:22PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> > Earlier this year, I debugged a stack corruption panic that revealed the
> > limitations of existing debugging tools. The bug persisted for 739 days
> > before being fixed (CVE-2025-22036), and my reproduction scenario
> > differed from the CVE report—highlighting how unpredictably these bugs
> > manifest.
> 
> Well, this demonstrates the dangers of keeping this problem siloed
> within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
> It was fixed properly in 7375f22495e7 which lists its Fixes: as
> Linux-2.6.12-rc2, but that's simply the beginning of git history.
> It's actually been there since v2.4.6.4 where it's documented as simply:
> 
>       - some subtle fs/buffer.c race conditions (Andrew Morton, me)
> 
> As far as I can tell the changes made in 1bb7ff4204b6 should be
> reverted.

Thank you for the correction and the detailed history. I wasn't aware this
dated back to v2.4.6.4. I'm not part of the exfat group; I simply
encountered a bug that 1bb7ff4204b6 happened to resolve in my scenario.
The timeline actually illustrates the exact problem KStackWatch addresses:
a bug introduced in 2001, partially addressed in 2025, then properly fixed
months later. The 24-year gap suggests these silent stack corruptions are
extremely difficult to locate.

> 
> > Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> > code in __blk_flush_plug(), I found it difficult to trace all logic
> > paths due to indirect function calls through function pointers.
> 
> So why is the solution here not simply to fix KASAN instead of this
> giant patch series?

KASAN caught 7375f22495e7 because put_bh() accessed bh->b_count after
wait_on_buffer() of another thread returned—the stack was invalid.
In 1bb7ff4204b6 and my case, corruption occurred before the victim
function of another thread returned. The stack remained valid to KASAN,
so no warning triggered. This is timing-dependent, not a KASAN deficiency.

Making KASAN treat parts of active stack frame as invalid would be
complex and add significant overhead, likely worsening the reproduction
prevention issue. KASAN's overhead already prevented reproduction in my
environment.

KStackWatch takes a different approach: it watches stack frame regardless
of whether KASAN considers them valid or invalid, with much less overhead
thereby preserving reproduction scenarios.

The value proposition:
Finding where corruption occurs is the bottleneck. Once located,
subsystem experts can analyze the root cause. Without that location, even
experts are stuck.

If KStackWatch had existed earlier, this 24-year-old bug might have been
found sooner when someone hit a similar corruption. The same applies to
other stack corruption bugs.

I'd appreciate your thoughts on whether this addresses your concerns.

Best regards,
Jinchao
