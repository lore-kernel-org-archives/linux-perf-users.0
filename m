Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5302D4816
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001182; cv=none; b=Yoi0jLqh9zf0MB5HtQnyObRueTfNQgVYeBheB978++2asZrB9Yy7IhUccuygY1S/YC845XhPqbyfWIjf2LpQ9DyYJOeRqL58q5R+2O0MkR4Ph9Ro8j75IdqM0WpfyCPNDW2uatPbyUZbdiOCDVj+AtP+w7wW5sJHMkI3YPXJzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001182; c=relaxed/simple;
	bh=7ov7X+H76YZ2kZPkU1rlQnIlT1HTKwdYcsZHXhrLcLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpG97aONusI2xg9Z6dapC1V+mMEv/CaVwIHqFBFacOxbjmF0Wi4nHBZx5hyxSxvnKzZLksfHXcHqrESk664sWO9dG4GmL4UTwCg/t6zk8aEbUweuSyJGWHhM/y5eQPJeG3qoJd+muItpEVZtUgcqsoAD0oPRw4V4MX7a8ChHff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW4/S7E3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW4/S7E3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so11925225ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760001179; x=1760605979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noGJIDsEGpbT4mVPtLItOHBIizt5I7YMxK5vpTBOvYc=;
        b=nW4/S7E3mJPgJ6jQdfxNFdKrAE20n0t2gB7AcVgIox9uLACU6iJgIHPZO+oPqwtKXE
         s1SHyT8RJPJ6IqzyjYpr/aS1Y7/6wP9n9ZofH9QunBe8uVE7De/4g6pEc+jG3IYNNKBx
         LlyFJ3EpJoUMYtr6SFRcbuisd1psr3+7y4lhCYh/IRELHsfyEQ7tn/GH8HzolaKSBjpX
         wxyumOy/PhI4FwjHTsNBJV/kjPcFwMloZhZjpySdwyr3cJn4j9HMO+2ftCnvuJd3mRKU
         P+JB08ekaTf08VpgDviak6LkMEQ5rsuOC6KcnEJ+hb7IbWu3HzPOlwo7IkYAGGz1WB+e
         LzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001179; x=1760605979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noGJIDsEGpbT4mVPtLItOHBIizt5I7YMxK5vpTBOvYc=;
        b=KccV+vvgcxVQOXdeY7HAra+zr0GUi0vO21rpT3rO/rfvcgn28uKNpvKhqXdZ3eqx0W
         AXhaj98UiQtIiCKW775zC/J3G+7gRSwndZtTAKfc9QnnfU7zf+ZNSi29Pdkz9WC4Eqoe
         iyOBzJ7sBxbfN/Gg99pyAS9QYxHRT2w9kNiYNF3sbV4vMV6pwbv+P8ozyI916boYbHKN
         /z3Iu94cZXKXIt9lQPSr+dk1qNul09GLEPH7YB2CnINWJ/IsYvjIMtIrm5pWPr3LszcU
         FHLjUyTcH4r1yWSgtBI6HhY9mNqeFAbTyJzF4Z5AcEmqneDF9dJ4KTNpUfuznX0YGdUC
         APqw==
X-Forwarded-Encrypted: i=1; AJvYcCXUoW6Lzyo+L7CK13dUz9Ii49qKm6NDB6EOHt51KB5u+yRfReIVKVvXmFexRsb7Y2ZMuNc0khoEhfIxfwVSLAMp@vger.kernel.org
X-Gm-Message-State: AOJu0YyukSjlmXZf7dRyh5dS0ONXALAC7BZXuC44wm1l+nE0nF7JA5t7
	QbeyzGRss7nu6D5J1U5Y/6Fj32gUKDPwvkDTAvsRk8Sf1dRXPXwSVHd3
X-Gm-Gg: ASbGncsgxb2U34GrOnyJlJ0Gbf4Fcjceh0uYh+M64NUjm2m46blkOs4zmkbfk2IbG2a
	0a+i/PxpJpRwj2HSCRklG+51kCkjODDz+RbSMw6eSH2kFx/RshFKi2+vYlhCtAlm0qTbLJnwOjS
	R7j7ANVxecPtE07+YMrB/SDfou4fJu2bK4J/pRTDTcLr4yCNgMM7zsTtXC1NtkI2fVwjXwLQEAm
	xd9keX2hjKOoO6fwqsta1220AjY8a0xYWwekWmy9f4fW6gxYwXXs7EOUJdks/mmxTK0WTE8DfZ8
	/iM9nOw3AN8bXUYUaI03xUVUJKkX6XJIbX3+Kk5o7Pg09YvTcBmnwiyYGWx3OfVBWeI5qOJsrGG
	R7U3dWC3hF0NLLc86G3/mP3hPc31hjgLMGvWbPpAWjWNu/IIDzgZwhtT3M0eslg==
X-Google-Smtp-Source: AGHT+IGgc722wX6cnZ4WMCp7pNtwV85yDs1WMyb3Ue3/XLDo0+KBsbutwCUcBiVTue/uMgVkYBWZbg==
X-Received: by 2002:a17:903:8cc:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290273ffcf6mr78713905ad.41.1760001179036;
        Thu, 09 Oct 2025 02:12:59 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm22026565ad.92.2025.10.09.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:12:58 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:12:50 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v6 23/23] MAINTAINERS: add entry for KStackWatch
Message-ID: <aOd8kvWYIROq99vx@mdev>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
 <20250930024402.1043776-24-wangjinchao600@gmail.com>
 <3913273d-12e2-426f-aec7-263b7f49008a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3913273d-12e2-426f-aec7-263b7f49008a@infradead.org>

On Fri, Oct 03, 2025 at 01:50:43PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/29/25 7:43 PM, Jinchao Wang wrote:
> > Add a maintainer entry for Kernel Stack Watch.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 520fb4e379a3..3d4811ff3631 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> >  F:	Documentation/dev-tools/kselftest*
> >  F:	tools/testing/selftests/
> >  
> > +KERNEL STACK WATCH
> > +M:	Jinchao Wang <wangjinchao600@gmail.com>
> > +S:	Maintained
> > +F:	Documentation/dev-tools/kstackwatch.rst
> > +F:	include/linux/kstackwatch_types.h
> > +F:	mm/kstackwatch/
> > +F:	tools/kstackwatch/
> > +
> 
> Add entries in alphabetical order, please.
> 
> >  KERNEL SMB3 SERVER (KSMBD)
> >  M:	Namjae Jeon <linkinjeon@kernel.org>
> >  M:	Namjae Jeon <linkinjeon@samba.org>
> 
Thanks, will be fixed in next version.
> -- 
> ~Randy
> 

-- 
Jinchao
