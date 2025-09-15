Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E66FBF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901796; cv=none; b=YfnlR0FEfvjJicrg4X6fuTJSuIKFL+x39tRJmQp2LPi64jV4X4pw+htU1xRotHpCXTTItnE8XfgtNpHYo3ImmSHZLTFmwLVmMF3NCt4kBR8vyczx7LEnCxSwL3lJ52jtUAMH/O5msJkdZ7taBU7fYG8b8+mj8dEw56ryJgp/+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901796; c=relaxed/simple;
	bh=dwEnk+JUy+plSH589xKHA8fu3lw4UwydsjYzisg/b04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwa2V16luiLWx60/7GJOaEKZ1T2vzfjabluFRZFcBQ5relmwLryYK+mYQE7d4gq/63oIAx0FJ+Dcc6/Z9EF46HnIscCmComlMcCzDJGOOlkn74+PbmZbobUFrlOifjWdc3SW2O/NiiO/iPERLL7HQ6aLHRSkguJ7NBdcyu6pEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv6Idl0y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv6Idl0y"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7728815e639so2476413b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 19:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757901794; x=1758506594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOygL22yeiI/c6chOsAL099+jLfX4ygYuBDAjkKbT5k=;
        b=Rv6Idl0yeeUOlPmqKUtz99fVG07ZJdK2iN/x3ppIkVirqgGRBiGaAJsS/gnAgadRW0
         2auYQj+tMxYTlIoF3pS6eG7e4fykWm070s/MSdZ/vDGvnpg956lXJVdmuhc4Wl9x7Wm9
         p97QO3U7X2RALUZCRBXTtpvco+axu40xlvQX/k6D9rgIs4ontpY2Y+Wn9phfKhloIfZj
         D4qOOF1XTJeACiU1dS9iPRHGY9FLSoiTd/iHGFQ9g7o5iJ0CzwZvxLWs5LtZ2yx7az1c
         e3Lbn16MUqWOppXSDk+aAcgRD5/dzkXnBnkinscXYgLi4he3Gml1pJBGjnX6HSF+JgwA
         8Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901794; x=1758506594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOygL22yeiI/c6chOsAL099+jLfX4ygYuBDAjkKbT5k=;
        b=Lume3QKnVjwNbo9AwB+TpNuB94wZPqwJncYy5KqXvCaSUV6nSq7Q1maVNM2yFQQfEx
         ho/ATQosqxfvzR5I8FdorNlgDqanYrzhNGarKa1OLzlspbDHTflgTC79yoAk2mBSIUP+
         3+4htscJlEv649lXuCwGgjjwPwhzdvswdext2bH6rBN/Ub2ox4amnEf2s0fvxKD9HKVH
         Dx1CzSgC3d+AbwghD13CRp2eWoePU3wXMj5nUsy0naJ/luJRQKCo7hfNms9Ne6oIv0eh
         Fgr9g77tG4a/VFZJhM1Xyv7PuKK6eRsTFnveQBuvHpFlxLfi3DYJSW/9CkJyB95oPrI1
         dkOw==
X-Forwarded-Encrypted: i=1; AJvYcCUaD4A9QAT5vNEPUpnxKnKJGLfPbUHaSIiptxOrkAhwR+vu2x6CLgbznP4SBggsoycogwCHpOqS5URVMiSSeFjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHrfrQVf34BsNgAWR552AQb6hM9ND7iwUGjyD+nQND9PZv3Oe
	bBjEQgROMRHfu1tpTHlGYYdlIGeiZl1TrcN7PZ/uoWBZG3/BabkROqJK
X-Gm-Gg: ASbGncvOv8WZH42H9hyqdcLcS7xZxbcRVnaMihVjoC0YxENh7Ab/zycQcvOrVj8hk6B
	daWOH0EmsjpvHlu5UzufcO+NjZAusPsnL0SCRh3bEhJ+L+efQU929ZDfTSTL3CQ9HW/G/MSj+B9
	K6G+dAUQ6d2VDA5QbYHdDJpvvQAB7bLpMsrb4Q93jZ+YxIVkZVwfKlG5E/arNw2CLcADjZ4iCxF
	Z+fjPaCWpA8tOpec6v4wpJ/hkg4UnbGdYQHLxqGWSTE5DtYOghrKWXIjMU70/bcWGWBRcugcF5V
	oeCldD4LrsdHNAdMZqR6DmAf3gakOfKIjbihTcKKvkkhYAFRkuS+9QyfuaGX3dIzpuItbh1oBzf
	UM05EJQtva5QjJu2Jqn5dvLnaKIqgiN0rrhvZG88=
X-Google-Smtp-Source: AGHT+IEeqkh40QJM9zjJ8HL43W+1enVBlgkaCaBCrqZXNAUnxXXVQNA79eZr3zdQ3nIBlPPQ1opd6Q==
X-Received: by 2002:a17:903:f85:b0:260:5bab:8cad with SMTP id d9443c01a7336-2605babb245mr90876965ad.29.1757901794287;
        Sun, 14 Sep 2025 19:03:14 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261333a972dsm51596705ad.75.2025.09.14.19.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:03:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:03:06 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/21] mm/ksw: add test module
Message-ID: <aMdz2gMb5YC3G3md@mdev>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
 <20250912101145.465708-16-wangjinchao600@gmail.com>
 <69198449-411b-4374-900a-16dc6cb91178@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69198449-411b-4374-900a-16dc6cb91178@infradead.org>

On Fri, Sep 12, 2025 at 09:07:11PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/12/25 3:11 AM, Jinchao Wang wrote:
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index fdfc6e6d0dec..46c280280980 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -320,3 +320,13 @@ config KSTACK_WATCH
> >  	  the recursive depth of the monitored function.
> >  
> >  	  If unsure, say N.
> > +
> > +config KSTACK_WATCH_TEST
> > +	tristate "KStackWatch Test Module"
> > +	depends on KSTACK_WATCH
> > +	help
> > +	  This module provides controlled stack exhaustion and overflow scenarios
> > +	  to verify the functionality of KStackWatch. It is particularly useful
> > +	  for development and validation of the KStachWatch mechanism.
> 
> typo:	                                        ^^^^^^^^^^^
Thanks, will be fix in next version.
> 
> > +
> > +	  If unsure, say N.
> 
> -- 
> ~Randy
> 

-- 
Jinchao
