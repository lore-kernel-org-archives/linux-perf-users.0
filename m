Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4071BDC3
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481822; cv=none; b=plVBBd8IZTj3tunHZsYXxD5IUtSwg2zgu5Nd7VJbzAZlkxdq+GGc5kL5/ReJr6k5D6E0lCoannNK1B9veusxUqbImuhTAT7Wv+ECzPIV4FKqKolLC27pXGPPIpy5BWn3BLLoyS8Gc/HFRIfhpsz5ry814wVjZFZpXw2kDEdel5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481822; c=relaxed/simple;
	bh=8aoJfoRE7+15dJoExHzjdMJUpg8MUKDQ4A8VV/wLmbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aObWQtoWLqcnYYoDGJ0p0dl6vcYiEcVtVNXUL7frSXoD/zxiKuOLBternHOoscMT/72/flhpdeo/1J0Y3o2Id+6UAQURpAWghd5yrLGUQyg/8Rw9bXBh2+vydyl9MQdjHrpNjFyKjQj9WQQwxa4LMvW/vBv5dv62S5fL8Qo3js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aICEC9yK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aICEC9yK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728f28744c5so5500489b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 16:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734481819; x=1735086619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cw55AKdZY3Iyzi7xSZCsR45xkksNMr90DAnnsKl2gF4=;
        b=aICEC9yK7zwnV7201rTX1CgWg1iJ5jJG79666ogVeZPZ4sUwOTAdq9rmbzbbpvaMdk
         KZlL7pAWaUjOTEFLo6SKKXdLIjWJqOpnUzRXsC2pR2YbWTFXd7/9d+OGYxLBzr8LNpQh
         hW5lXKxLghGmmdANro8oSXfhoG7Zo0zT7w8b24sypXfhrPTeiRfqimArFQWHCY7bjURB
         At4X/aUjKQjnj3Uq/GiAYymNbEhDk3YB29gEZaXttZg7dRhQUBRU3QrJTpUXGMv/qGUb
         Rr8Ul8rN3iTZtkwNFSwECHqYOFwo/UbfiJIJf/sjmh+5CGQSbOxj3vqHpE4IyrhrWH0q
         Fg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481819; x=1735086619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw55AKdZY3Iyzi7xSZCsR45xkksNMr90DAnnsKl2gF4=;
        b=RJ/G73OcrG+aIzfmZeeMqem/4fdeILT8uDjoaXPZ2K1PDQO0KG93rNB1gLEuI6sl0E
         UnUMCZMS7oG8ESclEV2Kfjs36ZfQydjSSg3BsZm5Mzq2KOLoMbsN7wqjtCY40PzzsdCb
         4Suc78NydvcFd1VYynKdSMrbs+q3XC69x7qbhC9GRl5xY5aJUTP9bo6rsoC91BlEXDNM
         Hq4BeLZfHZj3le9BRFJLJIjcE6YPzqR7nz6nI6a1DtvZyJBIgHXR6DUoZfyOhgceCRO3
         0kr8eUntnNoxARbhLLPo3p1hMv6b8ogVpIoLMByiFwcGc8R2djL790YbiA+2byZvncsW
         sLZw==
X-Forwarded-Encrypted: i=1; AJvYcCWdh4nx9x5bu1YFL0e3BmWJfsAsEdIbFEcIk5rKdUocB02YnJyBjiZ4JarMIjUOfedymW0qZZoSihS/NsbQFvpx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3xjv3iVW2A1EvDKV+vXRh89Jy6Yr2sbgaPqLWz8yZO9XDT63J
	DRKwuOTsQjdJrkPUvY7y5vyfc1uGmZmskKgv0ljdLj1h7RC2kBQ2Z0hw+XZ5EY0=
X-Gm-Gg: ASbGncs/CAyBU5x5Dw2dpnKTFkXbZfnI74QPH+yNSgoB3+Vss/GpOnLtVNxNT6WAGH6
	gp/Cjem6qSuVatqa8MVVoe7x4kucaIc0mxuOV/1IrtYd+AP1q1PasZM4FC7o3e7dZAmVqZOSdhR
	PTN9rigMCmzzMSfQyKoRY/bKUwYhTnN1orswBxYCxA8FdqbkcDXw2wgvoK/HW9QVwLutt8uC046
	RCIy5Btu6oHoXjXo3cDqBNTSr1WZxfs2IpQGiR2CNFg4yY=
X-Google-Smtp-Source: AGHT+IG5Cx6yPttPbYg5wTTofbNuEwnlOQqyTrXYd/ruQPCVe05gCE7tcoBeRNxbyUyUCgfsg6Vu2g==
X-Received: by 2002:a05:6a20:a103:b0:1e1:9f57:eac3 with SMTP id adf61e73a8af0-1e5b480f77bmr1790673637.18.1734481819597;
        Tue, 17 Dec 2024 16:30:19 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaea84sm5297831a12.26.2024.12.17.16.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:30:18 -0800 (PST)
Date: Tue, 17 Dec 2024 16:30:15 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <Z2IXl5cuKQJInJb0@ghost>
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>

On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> On Tue, Dec 17, 2024 at 3:52 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > After binutils commit e43d876 which was first included in binutils 2.41,
> > riscv no longer supports dumping in the middle of instructions. Increase
> > the objdump window by 2-bytes to ensure that any instruction that sits
> > on the boundary of the specified stop-address is not cut in half.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> > ---
> > A binutils patch has been sent as well to fix this in objdump [1].
> >
> > Link:
> > https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> > ---
> > Changes in v2:
> > - Do objdump version detection at runtime (Ian)
> > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > ---
> >  tools/perf/tests/code-reading.c | 84 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 83 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> > index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..7e24d10a543ac18ac2be70b829d088874e0edfd5 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <errno.h>
> > +#include <linux/kconfig.h>
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <inttypes.h>
> > @@ -176,6 +177,66 @@ static int read_objdump_output(FILE *f, void *buf, size_t *len, u64 start_addr)
> >         return err;
> >  }
> >
> > +/*
> > + * Only gets GNU objdump version. Returns 0 for llvm-objdump.
> > + */
> > +static int objdump_version(void)
> > +{
> > +       size_t line_len;
> > +       char cmd[PATH_MAX * 2];
> > +       char *line = NULL;
> > +       const char *fmt;
> > +       FILE *f;
> > +       int ret;
> > +
> > +       int version_tmp, version_num = 0;
> > +       char *version = 0, *token;
> > +
> > +       fmt = "%s --version";
> > +       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path);
> > +       if (ret <= 0 || (size_t)ret >= sizeof(cmd))
> > +               return -1;
> > +       /* Ignore objdump errors */
> > +       strcat(cmd, " 2>/dev/null");
> > +       f = popen(cmd, "r");
> > +       if (!f) {
> > +               pr_debug("popen failed\n");
> > +               return -1;
> > +       }
> > +       /* Get first line of objdump --version output */
> > +       ret = getline(&line, &line_len, f);
> > +       pclose(f);
> > +       if (ret < 0) {
> > +               pr_debug("getline failed\n");
> > +               return -1;
> > +       }
> > +
> > +       token = strsep(&line, " ");
> > +       if (token != NULL && !strcmp(token, "GNU")) {
> > +               // version is last part of first line of objdump --version output.
> > +               while ((token = strsep(&line, " ")))
> > +                       version = token;
> > +
> > +               // Convert version into a format we can compare with
> > +               token = strsep(&version, ".");
> > +               version_num = atoi(token);
> > +               if (version_num)
> > +                       version_num *= 10000;
> > +
> > +               token = strsep(&version, ".");
> > +               version_tmp = atoi(token);
> > +               if (token)
> > +                       version_num += version_tmp * 100;
> > +
> > +               token = strsep(&version, ".");
> > +               version_tmp = atoi(token);
> > +               if (token)
> > +                       version_num += version_tmp;
> > +       }
> > +
> > +       return version_num;
> > +}
> > +
> >  static int read_via_objdump(const char *filename, u64 addr, void *buf,
> >                             size_t len)
> >  {
> > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> >         const char *fmt;
> >         FILE *f;
> >         int ret;
> > +       u64 stop_address = addr + len;
> > +
> > +       if (IS_ENABLED(__riscv)) {
> 
> Not sure if there is a consistency issue here. Elsewhere we're just
> using ifdef, such as:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next#n69

I don't have any strong feelings about that. I can change it to be an
ifdef. On other lists I have been told to use IS_ENABLED whenever
possible, but it's only a small difference.

- Charlie


> 
> Thanks,
> Ian
> 
> > +               int version = objdump_version();
> > +
> > +               /* Default to this workaround if version parsing fails */
> > +               if (version < 0 || version > 24100) {
> > +                       /*
> > +                        * Starting at riscv objdump version 2.41, dumping in
> > +                        * the middle of an instruction is not supported. riscv
> > +                        * instructions are aligned along 2-byte intervals and
> > +                        * can be either 2-bytes or 4-bytes. This makes it
> > +                        * possible that the stop-address lands in the middle of
> > +                        * a 4-byte instruction. Increase the stop_address by
> > +                        * two to ensure an instruction is not cut in half, but
> > +                        * leave the len as-is so only the expected number of
> > +                        * bytes are collected.
> > +                        */
> > +                       stop_address += 2;
> > +               }
> > +       }
> >
> >         fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
> > -       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
> > +       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
> >                        filename);
> >         if (ret <= 0 || (size_t)ret >= sizeof(cmd))
> >                 return -1;
> >
> > ---
> > base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> > change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
> > --
> > - Charlie
> >
