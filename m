Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siTQluvu"
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D5110
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Nov 2023 23:41:21 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so2678285b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Nov 2023 23:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700984481; x=1701589281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQutg3u2Y2iW5xj3dqNis9sfyX8Z8w9JAIQKQGmC3W8=;
        b=siTQluvukd/YEddx4ZQD9f/XAdQbaLLrKZO5cSV/z/uA8ywNemAuQyQsyo486j0hct
         E+SmwQajmCWiZtHo98NJEJXcZxp5pS2iZOCKr/EtwJYwWFd0ew32/tvLKFep9kz5/jtL
         aznKy8ajrNgaYRdHx5mVXrdt26MjRrcDACJwx8Tblv/cDAQQLqhjaS/3hNbLtGQPKC0B
         /8vyWDD0VVvqJFnQqzCe6p68orx5MCD4p0KK4+WLxvD/Z8ixrRfy/pHw4x8jhe1+awPX
         tO8F9k6PnraAgBNYP57GlCMDl6QLh+3F9yN+S93nqoCaj+qcwQ4xMdPtmdx2g6o1bl78
         twfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700984481; x=1701589281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQutg3u2Y2iW5xj3dqNis9sfyX8Z8w9JAIQKQGmC3W8=;
        b=GSdVSgsg3crRqebHGFPurxc1bG8i5F7yvSn3oXzDc1U8Ycno+tES92xIxbwBf6g747
         b1U0Xi64AEfcseArgJ/oSiRpuJVP+qg1qSacw4lgBUCpJ3d6LomTZggjUtPZnxnqIKwS
         RcR+Ufa3Cr0Rx+slbgrJdQpmhXfn+opXALuVq6lzCIlbGZf8kpmvPMjD3lf058sr4z7Z
         tLnBA25SAMVAMm3eMafnXzmyHhY+9c/g75Awp3MUMUEcMIC/cDdScd3QJNZ2JCuT7PfZ
         cF6hkItiU/qGr5M4E5lEXieReHqXrKRWF19aJ5faYsV/KUlUjfzBMofmRzElYyiOEvM0
         1VEw==
X-Gm-Message-State: AOJu0YzS25QJPl7FMq01zJUm/NB3/f5oyhIgvmfhqU6V99yGnFlEWgzc
	F8hc++ZWZtaF1Ioy9+6pT6q9jA==
X-Google-Smtp-Source: AGHT+IEk01eTWgKyOPWBpuRW3iRCsHTEsBtfL1IGLyimsIsz9R8ssDDfzzrSNbx70mfqTtHn2eVtKA==
X-Received: by 2002:a05:6a20:e112:b0:187:bc51:de6e with SMTP id kr18-20020a056a20e11200b00187bc51de6emr10061391pzb.26.1700984480961;
        Sat, 25 Nov 2023 23:41:20 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net. [211.75.219.202])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001cfc618d76csm370134pli.70.2023.11.25.23.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:41:20 -0800 (PST)
Date: Sun, 26 Nov 2023 15:41:14 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Nick Forrington <nick.forrington@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <20231126074030.GA647134@leoy-yangtze.lan>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
 <20231125030529.GB178091@leoy-huanghe>
 <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>

On Sat, Nov 25, 2023 at 07:10:25PM +0000, Nick Forrington wrote:

[...]

> > @Nick, could you narrow down which specific test case causing the
> > failure.
> > 
> > [...]
> 
> All checks for ${testsym} in record.sh (including the example you provide)
> can fail, as the expected symbol (test_loop) is not the top-most function on
> the stack (and therefore not the symbol associated with the sample).
> 
> 
> Example perf report output:
> 
> # Overhead  Command  Shared Object          Symbol
> # ........  .......  ..................... .............................
> #
>     99.53%  perf     perf                   [.] __aarch64_ldadd4_relax

Thanks for confirmation.

I cannot reproduce the issue on my Juno board with Debian (buster).
It's likely because I don't use GCC toolchain with enabling
'-moutline-atomics' AArch64 flag [1].

> ...
> 
> 
> You can see the issue when recording/reporting with call stacks:
> 
> # Children      Self  Command  Shared Object          Symbol
> # ........  ........  .......  .....................
> ..........................................................
> #
>     99.52%    99.52%  perf     perf                   [.]
> __aarch64_ldadd4_relax
>             |
>             |--49.77%--0xffffb905a5dc
>             |          0xffffb8ff0aec
>             |          thfunc
>             |          test_loop
>             |          __aarch64_ldadd4_relax



> ...
> 
> > 
> > > I believe that it was there to prevent the compiler to optimize the loop
> > > out or some reason like that. Hopefully, it will work even without that
> > > on all architectures with all compilers that are used for building perf...
> > Agreed.
> > 
> > As said above, I'd like to step back a bit for making clear what's the
> > exactly failure caused by the program.
> 
> I don't think this loop could be sensibly optimised away, as it depends on
> "done", which is defined at file scope (and assigned by a signal handler).

I verified your patch with 'perf annotate'.

The disassembly on Arm64 is:

    noinline void test_loop(void)               
    {                                           
      stp  x29, x30, [sp, #-32]!                
      mov  x29, sp                              
      adrp x0, options+0x4c0                    
      ldr  x0, [x0, #3664]                      
      ldr  x1, [x0]                             
      str  x1, [sp, #24]                        
      mov  x1, #0x0                        // #0
    while (!done);                              
      nop                                       
20:   adrp x0, spacing.22251                    
      add  x0, x0, #0xa04                       
      ldr  w0, [x0]                             
      cmp  w0, #0x0                             
    ↑ b.eq 20                                   
    } 

The disassembly on x86_64 is:

    noinline void test_loop(void)
    {
      endbr64
      push    %rbp
      mov     %rsp,%rbp
      sub     $0x10,%rsp
      mov     %fs:0x28,%rax
      mov     %rax,-0x8(%rbp)
      xor     %eax,%eax
    while (!done);
      nop
1c:   mov     done,%eax
      test    %eax,%eax
    ↑ je      1c
    }


Maybe the commit log caused a bit confusion, the problem is after
enabling "-moutline-atomics" on aarch64, the overhead is altered into
the linked __aarch64_ldadd4_relax() function, test_loop() cannot be
sampled anymore, but it's not about stack tracing.

Anyway, the patch is fine for me.

Thanks,
Leo

[1] https://stackoverflow.com/questions/65239845/how-to-enable-mno-outline-atomics-aarch64-flag
