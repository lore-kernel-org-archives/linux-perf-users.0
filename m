Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6F315D4E;
	Mon,  8 Sep 2025 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311123; cv=none; b=bxaNRf/VcslmV4Kz4ICdV+HnUfICAWcorM5i0QhcuTMo/+9w59ljd6KlNiPeyoGqcq3FqxHv16A0OP3D7hjTRcF9ttEaYzvoVLss9r5CKwFJNqxG7xDN5+5SW4GCRAsANLn3EhxcghnICD68/Nunsh1QWzdQ9nhXmzSWiFjdpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311123; c=relaxed/simple;
	bh=cYPDUfj5hmDkdOlj79oLbWhNXIZOY5Po+8mrPYvPJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttPTSq1RK4+QqNS2m5nDbe9IOZVM7MlpgfcRaiTojxiOI6vswj7t4JqlbwbHdhRCLb0/gE2wahdu6xpH9wE22PYRmgJzp4TOcC9oY+14ix7OZBi1t1kPUTId2ejVGx5us2RpSD+ug5OOOvXIqa0oGZdYPCniRY2c7KEo1FrpF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfX939/w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfX939/w"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b13313b1bso29056115ad.2;
        Sun, 07 Sep 2025 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757311121; x=1757915921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQAO53IheHXnk98zkGI1Xh1RP2KJZB47OD8cVlZVsiE=;
        b=SfX939/w+GxCWn2TZkXKshjKQ9Ztc7lb3lxCBs+068IFZZxx5ADj+gej5rQQp5ZF1t
         xiPI2A1axJHp9UlCboe5YhcN4j+Uk9z/iTlfw/zsYgvl1o7EfjPs3a0aqw1BqHLVhAC0
         TijlJBG9To7CK1koSa9HEVUe9KB51WDrgAUJSXk0LGFy+O+HSH7wP7w9V/bw0J4FErpt
         J2fLvonh0h+rQdMHTc7yUX53d4sxIvZUY+FeRwMjjbZs8sCYx+x/5fFGIKvESKAY7YyZ
         xJ829C7ZVX7SbMU7qJiGdfW5RuVX9uWpgucCGPQ+YP5squH0/rDBsoW6aDRTDJ0rIRrE
         tf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757311121; x=1757915921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQAO53IheHXnk98zkGI1Xh1RP2KJZB47OD8cVlZVsiE=;
        b=ZTFe2fppX/on9+NzZGrVF5bSZEJvgHjQBkO5QIlXPsvTGg9rf/BlMHXP2M+We3P7Lo
         9/tRMKIGlPemLYtsLKuTYVq+FrUgM2iW6TDqEIDBn+wPquhv0/gwA3dnaKHxN0hcPuDt
         bodtPiOgK9VvpbxXxnDFKGZ8P5wGtoGf3I3NB7luDnPPmHsK3KarTYllRaYHYE5yDq1t
         a1P8t5BnnOX0ybthJDbb5HNB1jMYfXLwDFafIFMGRjd0sq7RTjAt1qIY9G1/V+6YLwWa
         IeWk0eo/BBgt4yPi1v34untC2SdXCx++oOVL+juu+aywHC5YMYJrNkOxumzUcY8phFog
         a1+w==
X-Forwarded-Encrypted: i=1; AJvYcCW91LSiWEt+f9+BvC+Muwe7hruuw0y3ygKh1oTrA1oFKU/PmVHJJ5Uxwke02Bc0TfT954VcJosDLmSzTV0=@vger.kernel.org, AJvYcCXQF5zDwYnwdkoXBJtJ3Vt39H2ERryDrqvNJDlwlVphMQluOzRgtCnH3OCtm1E5rdGtcF31kI7dmUVGZ5E6m0cFw1pF@vger.kernel.org, AJvYcCXntxWucfnbtaUDmu9HkLuXQmYNAgaYSRdokYNDiC6VJrvRuNVQVbcqcAHXArC2m/geeO8Kfm6koteeqKBQY6+Ylw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5Zs4ZJFwB/bkFKygNY9VgoAevIZOWIxs+dSD2F3Ji/1Gu1t5
	uKvdYC/VggMBBmELHdTvXdwhdJBKCKdtu76hCGOt+RPpWoY1V8+fsIB2
X-Gm-Gg: ASbGncvBhZ5MmwQYd2bEcfDLRufYMxN+g67tLxhk3KH9r0aBYZP1VdZyZvemg5EthQL
	CxYmvC/gJhqleCoXUfwX6n0gVRVoG3GfdMNFzqn3PexJSkodcnKQKV65wfOCtBkITPYDCvoihy+
	dysvpwjskOr7pq2T+qV7cXmUZSnK1bCkLaMXN4Lz18hIB/ixt9263++IAePPKjYbhooTNbQoKAl
	42f7HgpBUp4nNGRx3MJ9kd6+vnD64Wa0uf0VY23kdY3W0n3V/uWv9xq/KUbFzgqXRrTqWgUVUVK
	eIUwXdWNzgspjSXVvtbmsPnWk9x8Ixn44UaR09MtRQwu93Okm3dED00she0nW8VR+ujLW5guQXu
	PFoeUQjN6OlqOKGWy1gClraM/dHSXrXsXcMSfSQ==
X-Google-Smtp-Source: AGHT+IGaiMNB6Lomn1EdvRMYhV/HuuA9G/CRJ6puBizE2rFoQP4ulL6/ASUcZpM18sYQgH+KakQyOA==
X-Received: by 2002:a17:902:cec1:b0:24c:ecaa:7fa with SMTP id d9443c01a7336-25174ff5d11mr93448985ad.48.1757311121081;
        Sun, 07 Sep 2025 22:58:41 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89809sm236444905ad.2.2025.09.07.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:58:40 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:58:37 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] mm/ksw: add ksw_config struct and parser
Message-ID: <aL5wjbUYp3_qObzt@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-3-wangjinchao600@gmail.com>
 <aLlD-74aBdb-ZD5K@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLlD-74aBdb-ZD5K@kernel.org>

On Thu, Sep 04, 2025 at 10:47:07AM +0300, Mike Rapoport wrote:
> On Thu, Sep 04, 2025 at 08:20:59AM +0800, Jinchao Wang wrote:
> > Add struct ksw_config and ksw_parse_config() to parse user string.
> > 
> > Update `Makefile` to pass compilation.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  mm/kstackwatch/Makefile      |  2 ++
> >  mm/kstackwatch/kernel.c      | 70 +++++++++++++++++++++++++++++++++++-
> >  mm/kstackwatch/kstackwatch.h | 34 ++++++++++++++++++
> >  3 files changed, 105 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
> > index 84a46cb9a766..d422f0e114dd 100644
> > --- a/mm/kstackwatch/Makefile
> > +++ b/mm/kstackwatch/Makefile
> > @@ -1,2 +1,4 @@
> >  obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
> >  kstackwatch-y := kernel.o stack.o watch.o
> > +
> > +CFLAGS_kernel.o := -Wno-error=unused-function
> 
> Can't you just add the function along with the code that uses it?
Thanks for the feedback.

The function ksw_parse_config is called deeply in a later patch, so the
'error: ununsed function' would persist even if I added the caller now.

To keep this patch clean for review, I only include functions that form
a self-contained unit.

I will add a TODO comment to indicate that the CFLAGS addition is
temporary for this patch only and will be removed in a follow-up patch.
> 
> -- 
> Sincerely yours,
> Mike.
