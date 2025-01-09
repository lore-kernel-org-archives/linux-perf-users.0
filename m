Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6F2046A3
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457276; cv=none; b=ck9Pm6S7NKfQanB8NFMGPqTykR30XYlv+pJWl+7XGXARNV7hFuAyVprKuta71K0OfjB+Sk+b33WzNMd7f9NqoYsXTizDLm6tWYVCEBWh64FohfyV28o9pZPG2qbZrDecZD76JYfkagIKy+clONYN0uJ3P8Pld6/ZsMrDp+DKtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457276; c=relaxed/simple;
	bh=eYzvAapvrXbZXgh9jcwIv3jWk//AlYNgrkVgN3CMHpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efjq05CkYZLlUiUmvRqrziQA7jVCo9+dWptauT8C9SV/PLP/ehzW9RxjWDBMQ2aGW2yz2iwa6mDl1qAD7CUvuI+vGKDmwr2k6tV/qQYnB+JAjcaYkBPw8NuLt8L7IpLoAc88QcNh2ca8UH5VAS5OmJU69tb7n0pLtAztZH7VaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R0YnG8Cd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R0YnG8Cd"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166022c5caso22124305ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736457274; x=1737062074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWi0Eghj3xi161PysLI0KrpGNdQD8oYgIL/QlYOb5cw=;
        b=R0YnG8Cd03KerAHlX2oRKaYHqn8UXUNqY1Kbdg/Wh5RM8yrMp7yeCQWeSO3CSqzruF
         FgACscr9401LBSlZD2DiZ5lrr6brdqokDeRVJy137hFHePapiRhQKDpA39XoThklfnuN
         ApbG5FTMlhmRIULuoSQl3uyOUdDCoPvXYhX2vnaNPKO9wXI83hUIi0KkSNbjQ2ahvl4q
         hEwNIcf7dmv9XpX8lCKggPicGUxsUAmdfa7Q4a+vj6+afo3zvvVt3QKxUgVpBVTI1y9i
         VO7CSLRfuJttSVLwyiEYVK2SdN+t1OyK0efCibNObANRqYdvB2SK2338jbh84+RymfJO
         7krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457274; x=1737062074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWi0Eghj3xi161PysLI0KrpGNdQD8oYgIL/QlYOb5cw=;
        b=MAxWFv+ZN4hz5iN8NIl8hEqCSUTeY3x7CW/GBCpvFRkY3Awb770vjgfU8ZuZLh6Sb9
         Gwt+kLRlg6gsaEXdvw19awxRu1zxn7ABbFSYjoA+KTCtDz39lAnqWTBJyeS3pps5HNrr
         4+DurYfG8MqEMyP6s9k8G60+7TGCkvybYFnXuC3F6FN7FRQgi6zCneVmP+IBgTxe9Oab
         KacNsfGdM/s2R5w2GyczgzS4p5BC7rVJBzmMJPhjBKKLExQpQPPLrTbtDz/X48NdN9+x
         VH0hcX1WT/LmPOLLc+cQQJGoYdBU4xN/iK7i4bIR0esOlQPHRZWFKgIpNUBZ7Wf/dU+W
         Yr2A==
X-Forwarded-Encrypted: i=1; AJvYcCUgwzwypjmL/Gqy+5AK/2jZXC8bCoduiXVJQKCh56s4cG0DmkUJYq8iRwEaGTE1KL1qjC4UOOYXq7BX4ZQ1BdVk@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6MB8geW7lRjIiId3ap+fASgz7OR5EtxeCALM+vtcRsRqbq7T
	msZJmBU17HKxBgKgdLHROImL2VvJKm7lgYpnbVhUF9gYzwRMGqw8qlHxsWAVeds=
X-Gm-Gg: ASbGncuMHxBtouoXHUezUn3Ur1X92pM97/hJt9h72WrQWheLNZuwJFN5RgZNUPc6IFh
	4ysbpnyFMdlwCgHkqjPwjgOyDaAOO55IsYbcxfGU7zvks1dTZl2S2MTflN7EmM0eJWvZwXKs6Q+
	Luqjyopar9AhtUvvUek+E8K/62lryRrMuEw7DZUkl/BUrdnzEIMLvhCn3SWw+AdnLlViwV+AsQ4
	ZVO+IDh9vHS/Nkw3RW7ohB1ClVB+ZT9YcLp6/HsdB0nKOuype46
X-Google-Smtp-Source: AGHT+IGGpIFpDMCF6QbYUycaFsLmnN4FCC576ZSX1GeEVOuZ9RO46wvil+eTCx3t+IaGa75ky/Kjtw==
X-Received: by 2002:a17:90b:520e:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f548f424b1mr12478961a91.33.1736457273807;
        Thu, 09 Jan 2025 13:14:33 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad3b7sm4117850a91.31.2025.01.09.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:14:33 -0800 (PST)
Date: Thu, 9 Jan 2025 13:14:29 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4A8NU02WVBDGrYZ@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4A2Y269Ffo0ERkS@x1>

On Thu, Jan 09, 2025 at 05:49:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 11:48:36AM -0800, Charlie Jenkins wrote:
> > On Thu, Jan 09, 2025 at 12:59:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> > > d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove dependency on libaudit
> > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > > - tarpkg: ./tests/perf-targz-src-pkg .
> > >                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JJT3tvN7bV
> > >               make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.BF53V2qpl3
> > > - /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
> > > cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
> > >          make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.KZuQ0q2Vs6 DESTDIR=/tmp/tmp.0sxMyH91gS
> > >            make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.Y0Mx3KLREI DESTDIR=/tmp/tmp.wg9HCVVLHE
> > >               make_install_O: cd . && make install FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.P0LEBAkW1X DESTDIR=/tmp/tmp.agTavZndFN
> > >   failed to find: etc/bash_completion.d/perf
> > 
> > Is this something introduced by this patch?
> 
> I don't think so.
> 
> BTW this series is already pushed out to perf-tools-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> 
> Thanks!
> 
> - Arnaldo

Thank you!

- Charlie

