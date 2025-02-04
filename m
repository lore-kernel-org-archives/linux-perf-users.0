Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E50153828
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695940; cv=none; b=pIt/fIi5jQZYNwAUST6xtIuvYIhvCPDH2hmkcbnyyUjsjitYaKODAh47bjtVfFdlmxFnrV98E1jUMe+pfvx6WkRr6ShE5RBi8uPajXy49KfZD9BDBCnW41qVoiavD8C4NY/2ZednopmGf0rZGNT5kL0DRTMWBzFnvQWhIBBFNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695940; c=relaxed/simple;
	bh=EJjRuoZi9M6OG3JIhWDy+q4DoHqYACaysx+DRRTtyxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSHQIx8BJcOjNqQkAKd2vXX6K8UzQWkWIBOzs31fHh+g+BC9aTnRRN6hSrXfa6MTLHZqXwZq+rYnZQbxi3KtAbv5iwZwuTC4XYy+B6UCAlSJshrVRiVksl/fR8/AV4lPYLPGe6979QBSFIFFiBk3A9D14UsGPyZEPOQqyllXVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NAI39EUW; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NAI39EUW"
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso40331485ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738695938; x=1739300738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYITfMxdo9z4e5O1OPoM+RWhoGSmHNU/Bz6nSPQzi+o=;
        b=NAI39EUWhuoDGqi/mfgbZSgr9FZFSHph5trn/5UJFRbzx5P7hbfDb0ItGUPCt0a010
         Da9WcOmV0+XAAhnH4Icshq2sE5/cRgI83kWag5i8u5JH4yt8hb3QaOiB9Iv0Why/9sCz
         YZZMHE8zvywIbjRI3ndO4Jg6wdMg6rVX5aa79jkbGzRvrHc97IBqOv5mRXKtJ+HlbGRL
         d47fpkiezPIshkX0RTjRtyNtEhdyopBbpGQIebw/j0QE6vkzlxm8lhEVM2XgvQ/eNdbM
         6CBKTRT3n8B+wNIQOC6TLJfrkbcBrZBY0sog8NhiXVFvEGr7qgAbWXiu/jHt99nbSBNp
         9w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695938; x=1739300738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYITfMxdo9z4e5O1OPoM+RWhoGSmHNU/Bz6nSPQzi+o=;
        b=cY8nTJnem9Ondoe+e6Bsz4WO5o5Q2pFlKwSvKEBz3YdYgfDV1mQjih05fGTr/IJhx4
         9TND0Wx+JA+SsL2Y3M16fMfW5vv8oB8g4Z1TaX955EnBeR7yjf1AdgFW/9u8TxhdOaJt
         MWW8t17qc7+28DU+QM7HZha8WhQLTXUXNEXTqrhv4tyIybwJOVIbiLE5DNgZCj9jAGm9
         NrGEpmLmLwdjKSdggxD17803tTG33IUmQhKe8g94SEzHDAsp2OdjARGIqg0JkVD4HD1z
         dPTfd1sEnQ6VSoR1cpjB0I/belKXbyjx2mgyATYj+sYcuTZvjuwsXes82QuUiHhwMUCB
         ycWg==
X-Forwarded-Encrypted: i=1; AJvYcCWN0PEmmiA1b1269OEPhzOrvkAOYgYwqXIhkBIyLMz65vgEIAefIMtmZjt7EQxT7TJfhA3rfHB6JNw67jxbQMhF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5eHcHZKmrLpb5ehYXdEhmSrRofXQMeBKoIM1bmcqU8EGR+kM
	iQovfUOsAlitxZBymTg10BwKhhbsJZhjIbPKfhy8V/MxVZcc9eAZ7ICF4Sb+JOk=
X-Gm-Gg: ASbGncuspuI8/jBTc9GDBGjUFRBMKopR9tWa1vdovF7tXwxHzHGZLDKnF9JvT0V/JHg
	WTg78e+XtAvBttWEMXBHopLMG3B/w67Uc6gPgGHUz3vHFRYOLoyaJyxR9qBzobIntNwwd3lxkol
	CBMBpwUygBEKjB4yzJt8l/qS9r7/1+gKKW2ISGMvmN+Ocda/J3PYudsiX0zJs0kvSjiNint1knW
	+K7dXJ/udIPbsW7JVAFJlM3P1tsCTlzj2EoXQNyhft8bcNgZKynn+F5Nz0iQeBc37/Q0XjfVdh4
	GuEDOg==
X-Google-Smtp-Source: AGHT+IGX0H3nuw7h5Pjn1noXiepBaQQUopjt9QfDVUMZhCxuDfrTzW15XFUboTC/O2xCeIBQM6sASg==
X-Received: by 2002:a05:6e02:1945:b0:3cf:bb11:a3a4 with SMTP id e9e14a558f8ab-3d04f6e596emr607745ab.15.1738695937767;
        Tue, 04 Feb 2025 11:05:37 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7469eee7sm2833134173.91.2025.02.04.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:05:36 -0800 (PST)
Date: Tue, 4 Feb 2025 11:05:33 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the
 build
Message-ID: <Z6Jk_UN9i69QGqUj@ghost>
References: <20250201071455.718247-1-irogers@google.com>
 <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost>
 <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
 <Z6Eh1QLuqTbUKLCc@ghost>
 <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>
 <Z6FLDHz6V5L-HGR7@ghost>
 <CAP-5=fVk6N=FVXsJ9xRJZhYSh2sbmUkEPr5HqRd-pR7mbGts+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVk6N=FVXsJ9xRJZhYSh2sbmUkEPr5HqRd-pR7mbGts+w@mail.gmail.com>

On Mon, Feb 03, 2025 at 05:58:29PM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 3:02 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > On Mon, Feb 03, 2025 at 12:54:59PM -0800, Ian Rogers wrote:
> [snip]
> > > I think it makes sense in the kernel, as the built binary doesn't have
> > > cross-platform concerns. This is probably also the reason why the perf
> > > tool has an arch directory. Let me know what you think is the right
> > > direction for the perf tool syscall table code.
> >
> > I am hesitant about moving all of the arch-specific syscall generation
> > flags into a single file.
> 
> In these changes I had a single file to build up a mapping from ELF
> machine to syscall table in an array and I wanted to keep the logic to
> build the array alongside the logic to build up the components of the
> array - so the ifdefs were visually the same. As the scope is a single
> file and the variables are static, this can give useful C compiler
> "unused definition" warnings. You can trick the linker to give similar
> warnings at the scope of a file, so this isn't a deal breaker.
> 
> > There is currently a really clean separation
> > between the architectures and it's possible to generate all of the
> > syscall tables for all of the architecutures based on the paths to the
> > syscall table.
> 
> This doesn't happen currently as the build of the arch directory is to
> add in $(SRCARCH) only. So
> tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls will only be
> included into the build if SRCARCH==arm64. As I've said I'm against
> the idea of the arch directory as it nearly always causes cross
> platform problems - not an issue in a Linux kernel build. We recently
> eliminated dwarf-regs for this reason (and hopefully fixing up cross
> platform disassembly issues as a consequence):
> https://lore.kernel.org/all/20241108234606.429459-1-irogers@google.com/
> We could have the syscall table logic not under arch and generate
> multiple files, but we'd be adding extra logic to pull things apart to
> then pull things back together again, which feels like unnecessary
> complexity.
> 
> It seems in your changes the Kbuild and Makefile.syscalls are running
> in the arch directory - this feels like a lot of peculiar and
> separated build logic for just iterating over a bunch of arch
> directory names and calling a shell function on them - albeit with
> some arch specific parameters. There's also an extra C helper
> executable in your code. 

Yes, I can understand why you be opposed to that and I don't have a good
counterargument.

> I kind of like that I get a single header
> that is the same across all architectures and with no more build
> system requirements than to support ifdefs - in fact the ifdefs are
> just there to keep the code size down there is a #define to make them
> all have no effect. I hear your "clean separation" but I also think
> separation across files can make things harder to read, state is in >1
> place. I've tried to cleanly separate within the script.
> 
> I do think there is some tech debt in both changes. My:
> ```
> #if defined(ALL_SYSCALLTBL) || defined(__riscv)
> #if __BITS_PER_LONG != 64
> EOF
> build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
> common,32,riscv,memfd_secret EM_RISCV
> echo "#else" >> "$outfile"
> build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
> common,64,riscv,rlimit,memfd_secret EM_RISC
> V
> cat >> "$outfile" <<EOF
> #endif //__BITS_PER_LONG != 64
> ```
> means the perf binary word size determines the syscall table support.
> This is because the e_machine in the ELF header isn't unique in these
> two cases and having both tables would have no effect. You've moved
> this into the env arch name handling, but I think having >1 way to
> encode a binary type is suboptimal. There are some ELF flag ABI bits
> that resolve disassembler things on csky, so perhaps a resolution is
> to pass ELF flags along with the machine type. I'm not clear in your
> change how "32_riscv" is generated to solve the same problem. Imo,
> it'd kind of be nice not to introduce notions like "64_arm64" as we
> seem to be always mapping/normalizing/... these different notions and
> they feel inherently brittle.

Maybe it is brittle? It could be mapped to e_machine, but that just
might not be reasonable to work into the method from my patch.

> 
> > What causes the arch directory to be a pain for Bazel? I
> > guess I am mostly confused why it makes sense to change the kernel
> > Makefiles in order to accomidate a rewrite of the build system in Bazel
> > that isn't planned to be used upstream.
> 
> It's just software and so the issues are resolvable, ie I don't think
> bazel should be determining what happens upstream - it motivates me to
> some extent. For the bazel build I need to match the Makefile behavior
> with bits of script called genrule, the scope and quantity of these
> increase with the arch directory model, extra executables to have in
> the build etc. I also imagine cross platform stuff will add
> complexity, like mapping blaze's notions of machine type to those
> introduced in your change. It is all a lot of stuff and I think what's
> in these changes keeps things about as simple as they can be. It'd be
> nice to integrate the best features of both changes and I think some
> of the e_machine stuff here can be added onto your change to get the
> i386/x86-64 case to work. I'm not sold on the complexity of the build
> in your changes though, multiple files, Kbuild and Makefile.syscalls,
> the arch directory not optionally being built, helper executables.
> Ultimately it is the same shell logic in both changes, and your
> previous work laid out all the ground work for this (I'm very grateful
> for it :-) ).

Thanks for elaborating on this! I do wish we had more of this
conversation on the original patch so we could have molded the original
patch closer to what this one is doing. I know you did mention you would
like to get rid of the arch directory as feedback on that patch but I
hadn't realized that this was the direction you were hoping to take
this. It does seem like the changes you have made in this patch will
lead to a something that is more robust and simpler to maintain, so we
can move forward with reviewing this patch and stop reviewing the one I
wrote.

- Charlie

> 
> Thanks,
> Ian
