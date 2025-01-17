Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA18189BAF
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127554; cv=none; b=WSnfcPxEZrZdSUC8oNAqMHkyvRBkXkmY2qnXZ5JwC1OG9cBHvUUMiRtgHM0V9s+STFAFgNib2bA6F6cA8mXgNraJYScTYIv8bPfm98wDgFwPLvr56UHO6EX1PY4z/Pu+rFvvVqtNuQfEWUeCbjGiSgmHaQla+YV7DOwFn8cZvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127554; c=relaxed/simple;
	bh=6DE9vuKFSEA1KS0VYNiNovYjAz7Lk/cPOvdu2tw3vf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bb5MNQh8H4LQaa8xae53oQ68SGCxczK9NYp8IDEFHIVPW3FY0L/14+WadKJOo0odqYJYRSgMi3eJW0galPEK3qhF+LDAFOS4luq1pF78JQY/WreUZjDVh3TmbM+Dn3Pcx0ZqY1GpelJSuYkWvkpUSaX1On6PFm2eurubRnCN250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym08uVkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym08uVkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737127551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DE9vuKFSEA1KS0VYNiNovYjAz7Lk/cPOvdu2tw3vf8=;
	b=Ym08uVkcxG/LDWcPufyk3EDK78hqCrO3IGQa2hhnh7B93evjAagdhiK6AHe9uD+Z85ouJf
	f1oqESpwIo7p4AixD/Us8mS4LZrSS/chbYqm4cEBa1yAwa9sisdfBMdw+7kNFOYGmwcJZr
	HzNWt6/Wa3uDXkzJvmceFFdVeWwq8Vs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-esn8FGXjM2KOJGiD-UhPlQ-1; Fri, 17 Jan 2025 10:25:50 -0500
X-MC-Unique: esn8FGXjM2KOJGiD-UhPlQ-1
X-Mimecast-MFC-AGG-ID: esn8FGXjM2KOJGiD-UhPlQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso15963785e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 07:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127549; x=1737732349;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DE9vuKFSEA1KS0VYNiNovYjAz7Lk/cPOvdu2tw3vf8=;
        b=NyWcqlEhAsGInAAkjQ8gxwSxnZpqui+kfY47GKj9QQa8Bmrd8WJpSsFnh9tCglTLyE
         +NbXyqbSBnN47msALlSwhyPLzi2DSA5PRjOhM5z66+2lo9kMNHJwxXJMXyGnrbLzXIgo
         U5MozfXY9gcozUlaeuoEog9WamFQREAK0en9WQ2LJXPazKI4WhRcPvG2O6Oa0PtMdcXm
         /CZVIb89p4nty2wWsDzva15d1xsXvgtUtAQLhXUWnILliCbWEs11pe7XdC9TIn6TQk0w
         jn6YG4ioedqNQZrRXo0WgjkqB+c5N9vCVMPupuYwPbEb3OXUQmCPDcmW8MKMtfXZEzDX
         Pc7w==
X-Forwarded-Encrypted: i=1; AJvYcCV5OYeFu8bK/OSSmMQuK5rOAUIcJ+tDufACcWV1fn/v8dEa0egLbVLvorDjcj33Z3w+tws4AVjuO00XlF8+fIgp@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNJQGmurUNR35mQdlIgt0wh7WhoHBvhZL1wxlQLTPwCTF1Zjn
	s4gk6AlI9f03luzpVqiUFHJukdY8mPgF/iW6VFiJ/JcY1oSzQS+5jj/hAVjowpQA16klWkc/bWf
	vlm2gIy/Zau1isb460tY1BrjAUVX2UP7i45CGNWDFGt4DlMRDMzq2GcbLQBo2GU6ST/A=
X-Gm-Gg: ASbGncu+7k1xoMSD/2pYIlTwAE3QndU+22d0MJXhZXOuIbA1fCstUgjFaMPVeqpmrGV
	rp0hodKILVG8YKPErL1QgvRJudaLLvzf711Qi7j8DHBopD0kbW89ytbDqUqShl8mkxX/7mHLQO2
	di6gJN4t87NppjTYyfCB42texxhw3VpD9N7dWf27lg8TMj5vaPipgvYVlVstQAUOVBiosRTm4U2
	2bEzyjs/4cLE1Jb4sGmTFPthYKKJ9g4qNiamdQQIgoF7vBeVUsxGIpPJZexi6YqfUq3OlESGINI
	Bsu6UDWm+11xkSaRIUF2p+Q+OoyD9uoXjjWGoHsrPQ==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-438913bff57mr31772725e9.2.1737127549302;
        Fri, 17 Jan 2025 07:25:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0gMZqDwGTwzxqPbq5mivOriCCRRTxthl4OtSHet5NBdrE0Nd7orMMIHX4tKohkjx8g0xD5Q==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-438913bff57mr31771625e9.2.1737127548862;
        Fri, 17 Jan 2025 07:25:48 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm36969035e9.27.2025.01.17.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:25:48 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
Date: Fri, 17 Jan 2025 16:25:45 +0100
Message-ID: <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/01/25 19:16, Jann Horn wrote:
> On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> vunmap()'s issued from housekeeping CPUs are a relatively common source =
of
>> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> flush_tlb_kernel_range() IPIs.
>>
>> Given that CPUs executing in userspace do not access data in the vmalloc
>> range, these IPIs could be deferred until their next kernel entry.
>>
>> Deferral vs early entry danger zone
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> This requires a guarantee that nothing in the vmalloc range can be vunma=
p'd
>> and then accessed in early entry code.
>
> In other words, it needs a guarantee that no vmalloc allocations that
> have been created in the vmalloc region while the CPU was idle can
> then be accessed during early entry, right?

I'm not sure if that would be a problem (not an mm expert, please do
correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
deferred anyway.

So after vmapping something, I wouldn't expect isolated CPUs to have
invalid TLB entries for the newly vmapped page.

However, upon vunmap'ing something, the TLB flush is deferred, and thus
stale TLB entries can and will remain on isolated CPUs, up until they
execute the deferred flush themselves (IOW for the entire duration of the
"danger zone").

Does that make sense?

