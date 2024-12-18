Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438C35948
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734561145; cv=none; b=tMX2cTvz4rpVeWgtz6NgqYBQvVN34IiwAHp6sM/0zKlpCsP6YZ33adi8rO6evGro8wS185i33hhz7kdIo9P38C6t4nrgQXyC1PVLkoJBjiv8EQBBfEYstEM1NnXnBoTrNQwyN7j9XC3/dhXJFP0JnqTRkl149c1EsYN57j81BRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734561145; c=relaxed/simple;
	bh=vUAWp67MOThBgSGXEmUuoJl/4RAoHlEyQjf1TQeDOPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I08fbt2aauLXwXYkT7LGgNI7EXIw9skpozFQpSDtWOyXLzV2sxCMjfKwEm+AvdodvL7KX1ohYtnB6ZgoCmF9V0E0IGSmcY9fy6C18GfJOSsZbluIUwNNT5UZB6ANhuvmsIdyW8+EowDIb92mPgMsM5yWSWeiY2OodLdBqqssxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BTXUFDGZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BTXUFDGZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728eedfca37so196277b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 14:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734561142; x=1735165942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tR2taGENppW/iUu90JVKcmqf0YwVCgPjkxt8Ee6iXLM=;
        b=BTXUFDGZ5h9UbOHuBjO15xbG6lPmiYW6/1iGI2Aa1a5oJBwA+9Pefl2uw2FAXG9MSJ
         WbyCZKa0TJN3jEAijKunQo+Epbx90eGRZPe9tvrZjm0DtHCGZtjmufBifJKPAlVW+AVm
         90ITee6DaQLKuXqYII74uhNvUJ6QQW/O/ACcOHMKtCMal8NvRA1l3YQ+yhrli/RbPY40
         2ZszCknEQiadF7kcwaP2CNqE+3IRUe2Hh5yqbWMBDoLQUhsDSHtDWMR3hi1whi363Hxo
         DPl8yrYsT/ZDl0moi/kuuhcuahD35vYK0MLtQG1MvzK4QJFznnMNSkZ7o34dAJH5ANsu
         qiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734561142; x=1735165942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR2taGENppW/iUu90JVKcmqf0YwVCgPjkxt8Ee6iXLM=;
        b=SHUvn0QfkaTuii3Tx/8lhPs4PjRUVkNjKpnhvfbSfFINrBbWeO5bYN496W91kv/5to
         wMjGtcYvPaGDUmqp4ERjdN0JimFa1MtvMtPa3aiTW/BJGtHv8PvnSkxYPqTqVEN8U93I
         0w4ucYWHCtv4VhEUjjTD7ph+Bp66G6VzIQLSpQbv0jMEGFk6BMclD7hThT6OTxhh1dE1
         VNXQ5+f3TUCnaskWwkT1gQOTWmVzKR3dZtjD71cNgJpP3OA4yT7KzIvRBaRpAi1FwNoR
         UJwCJBtL0MgsXQ6sD2uXAaCJOILODL08JMX56GPH6XyTb9izjjzpq0D/OA6fhIZ0JYef
         HhIw==
X-Forwarded-Encrypted: i=1; AJvYcCXSXee0sX0BMqn7VSm1OxXf7+TCPXEh8WHPN3WzjKd/ug4GLPwAB+NTtayJFGjkVGU2lAOBJ6PHFNfBj6SWQbz+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6K1vpALuQYHDZwKqhdUsau4B2bwpUCU6Ah8EI83COz94H0tQ
	VIWbTLeKbQtlqvj8njVXEZ1K4dfAnaSce9ysh1i2U1AUCmUVjouYpcYpwDcHRMo=
X-Gm-Gg: ASbGncvDKmoO36TFGZYxJaba87IqP//Tvww/BQPknqGFpIZ8XwiJhNSoQx+VMFjUdcf
	WzTaYesxaick1Oog90cvTblToSA8skDorx+JTwDGoeWUkfr6WXabIxallutfjq7ic5fTJBoEN3T
	ugslaH1QHIYKF//whEqF7kF1/4YE98n7qZ6KDY1V4+IHwY9YqYaBSrHxm61WOANctK9k1QdarfA
	Gns//cQCCjLXMpoUpp9uXXFMyN7EikKgyYfspYfhDwyC5w=
X-Google-Smtp-Source: AGHT+IHkiFcBa5uPuKT7UiL19eDTHUTi6KXt8+yHtGVZYu79llIqo/wEI2THlg8fTSaZjVFrzOex2Q==
X-Received: by 2002:a05:6a20:7487:b0:1db:ec6b:ba13 with SMTP id adf61e73a8af0-1e5c7527e1emr1560271637.12.1734561142517;
        Wed, 18 Dec 2024 14:32:22 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac52bfsm9384916b3a.26.2024.12.18.14.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:32:21 -0800 (PST)
Date: Wed, 18 Dec 2024 14:32:19 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z2NNcy1jCLqb62h2@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
 <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>

On Wed, Dec 18, 2024 at 02:13:20PM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 1:02 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> > > On Wed, Dec 18, 2024 at 10:41 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > > > On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > > > > After binutils commit e43d876 which was first included in binutils 2.41,
> > > > > > > riscv no longer supports dumping in the middle of instructions. Increase
> > > > > > > the objdump window by 2-bytes to ensure that any instruction that sits
> > > > > > > on the boundary of the specified stop-address is not cut in half.
> > > >
> > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > >
> > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > >
> > > > > > > A binutils patch has been sent as well to fix this in objdump [1].
> > > >
> > > > > > > Link: https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> > > >
> > > > > > > Changes in v2:
> > > > > > > - Do objdump version detection at runtime (Ian)
> > > > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > > >
> > > > > > > --- a/tools/perf/tests/code-reading.c
> > > > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> > > > > > >         const char *fmt;
> > > > > > >         FILE *f;
> > > > > > >         int ret;
> > > > > > > +       u64 stop_address = addr + len;
> > > > > > > +
> > > > > > > +       if (IS_ENABLED(__riscv)) {
> > > >
> > > > > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > > > > using ifdef, such as:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69
> > > >
> > > > > I don't have any strong feelings about that. I can change it to be an
> > > > > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > > > > possible, but it's only a small difference.
> > > >
> > > > Can't we just use uname here?
> > > >
> > > > So that we don't use kconfig.h since its not used in tools/perf/ and
> > > > makes it looks like perf is in lockstep with the kernel source tree
> > > > version it was compiled from?
> > > >
> > > > $ git grep kconfig.h tools/perf/
> > > > $
> > > >
> > > > BTW, what would happen if I collected a perf.data file on x86_64 and
> > > > would read it in a RiscV machine with such a objdump version? The same
> > > > problem?
> > >
> > > This code is in tests hence thinking that a separate fix is needed for
> > > that problem. Hopefully the use of elf machine/flags tackles it:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n25
> > > We are getting somewhat disassembler heavy. We have llvm as a library,
> > > capstone as a library, binutils objdump and llvm objdump. Given the
> > > pain with parsing text, could we lose the objdumps? Similarly for
> > > addr2line?
> >
> > Are you suggesting to remove this test case entirely to get rid of the
> > objdump dependency? The goal of this test case seems to be to check
> > objdump and perf return the same data, so it doesn't seem like there
> > would be an alternative to using objdump.
> 
> I can imagine having an objdump dependency for a test but not for some
> more core like `perf annotate`. We have to do weird things when
> parsing text, like this code I'm not proud of:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/srcline.c?h=perf-tools-next#n523
> The issue with that code is that LLVM objdump has changed its output
> in newer versions to be closer to binutils objdump. Did that break
> perf? Maybe it just broke what our variables think is an LLVM objdump,
> but things aren't really broken. This kind of issue doesn't occur with
> a library, although the differing needs of library versions is a real
> thing.

Yeah doing the parsing of the text output is not ideal... For this test
case it should be possible to dynamically link against libbfd. I would
guess something similar could be done with llvm-objdump but I am less
familiar with that. I don't know if that's a good path to go down
though.

- Charlie

> 
> Thanks,
> Ian
