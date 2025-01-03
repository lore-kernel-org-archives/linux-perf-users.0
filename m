Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3A1F9F58
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931728; cv=none; b=Kist7cjSiTcpRl+mTnCHN82FlI3rTF2KGbdElWL+KHqU42zPAykXwY0D1+10jqcx7Kx+uwUI/q+w5te7PgUUUYna+p/RdpZid5D6dzEQFLF/75L4M2SglyNjXgHV5yy95fy+ksYagSQx85wUIqYHgSwMdbVcLBhf7NftF7oF+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931728; c=relaxed/simple;
	bh=HHwL+5SpFOMyo+dWaVwTT9ZG/HsdAaRzZjq78yXwUiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkZqcVzGLnCbu0m/6b2efj2yawc+ETEzl2Aa5nGqvBd27lOca2aLT/8dOv9cOOoAjeh+8mGK/9j49U06xlebJxtNQg/oLhzBRQTLEtqDsKTFqikuVKO6Lx9l5QPvLv+dtKMj55kRCci5ISRw4TFrSO8plzxiET1mGIutOScDORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W4LVVFcX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W4LVVFcX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21669fd5c7cso178012545ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jan 2025 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1735931725; x=1736536525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADhotle/1TQemJtHksRH5tzPPxcFcmn+moP8E9RHhKE=;
        b=W4LVVFcXr5zGTWUWG9ofYYXtxrj3+9d9qQ3YyY1AH7CPDK92tItDxIK5sAV4p1p9h6
         y8UGX75k7a+2V2NjaWTkNqFuMbA/uA559G7oQwwZD3aMkU9GylwyWT4qwuE6MCgYA1Tb
         KtNm9+w7Q3W0gXJd5riQSHB4w+4cvesh9Pfq5xZitmDUh26X3dvuhEvdz5vNrfrI3DU6
         6gPsCk2V48Hv+Q5mfWk4hsCCfEDF+aYTbEfySLcIy8xXeHSbZFomg4DmwxRfvDnFbYt3
         KUcNOX1QqAhjObwpcH9ZOFnjmZSLmpj/fmACKHG1ue1vS6M0Ep+8Jqfp+LbPMzEQmL//
         VkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735931725; x=1736536525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADhotle/1TQemJtHksRH5tzPPxcFcmn+moP8E9RHhKE=;
        b=LRyaIsBeLFnrbjm1zPb+lN+FZCLlOD10TB3zBg05ocyI5cGvL/338NVPFJsHtfygLb
         Ey5kTJEKx8hHu5pBRdYrsIpgvzMFpEoCVFR/Gq3Tj52AcVRY8V51KhzQl7nsHL3OLlWP
         zo9GV+zoUjZQsQpzv7DTtGKNRtwsJXt5ErRa6ZwOz2Bkfl+8bTMeQ/+KfJRhZmM7mf8u
         pdFKo1FWZaFZoXHbhDpIGjvWS8mMES61r5Htc05fFX2Wf515M7+5cDw8N8AtuD7C6nha
         w7r0f9zrMEVEF+8amWmQ321COFrotyBxlUhcZ8FQ7zQeNjnAYTYl+7FROfkCS/L5BCB3
         Ze7g==
X-Forwarded-Encrypted: i=1; AJvYcCV6A7C5moCoCuYHu7Dbr0zYqgqWPdermCRH++Gux9KQTb4xJ5GjwWFmZ+q8tFS2yQSO2huQDWDURLuFmvAUgoDT@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsgASwVf08fGLsN4vK8gy8puOcZ2xKcerxVrkq6koupuzHpd7
	tq/TQ3pZmpxsZhI4pGkuWZpChYL6jpr9fDp8kUvd8y6ZMq5hAFx/AjQcjwtwtHE=
X-Gm-Gg: ASbGncs1NVxOuhoWTpkF4RyC9UzJ5F/hAp0MsQSBnbu145XjuqFBK19uWZ3I24Ov//K
	MUI9R1oInHpWYZf+d1jyD6CESuYhJHTH/UBLy6N6efvXjmAY7OxTGWduyA3AV+7/r6PPU4sa7R8
	e9D78i2R5/cRRCxXmpm5bG9qP0RTadwFxTgvXXmsGwJK4kosBj33vwcCjIUoshQrPA3EIGlBkV/
	wPGN0Vps0Eke8Zfx5Y9km/0z9QZajwN/YVAaHIQSmzhG2ZzHJo=
X-Google-Smtp-Source: AGHT+IHaGUpdPP/4NVVkV9pM3dpsY14vT8nNjSq+/lATASDlWQ+Up7g3TCX6COowkeiTogzmOyYEVw==
X-Received: by 2002:a05:6a21:9007:b0:1e0:c954:ea7c with SMTP id adf61e73a8af0-1e5e049a0b9mr71239375637.27.1735931725624;
        Fri, 03 Jan 2025 11:15:25 -0800 (PST)
Received: from ghost ([2600:1010:b0be:4797:42a0:3cad:ff5:6bb5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba99sm26335019b3a.92.2025.01.03.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 11:15:24 -0800 (PST)
Date: Fri, 3 Jan 2025 11:15:22 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Z3g3SrBwQcXWdbRr@ghost>
References: <Z2IXl5cuKQJInJb0@ghost>
 <Z2MXXFhUzoQmW4xV@x1>
 <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
 <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
 <Z2NNcy1jCLqb62h2@ghost>
 <CAP-5=fUBcu=Kd7StJvwdM_ArnSdOjmAcgR7NzDd+Ep8LrNMhyw@mail.gmail.com>
 <Z2N8WLTmh0ojIzhF@ghost>
 <Z3dBGM5L41v0RlZf@ghost>
 <Z3gVrzFd_2cacOFD@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3gVrzFd_2cacOFD@x1>

On Fri, Jan 03, 2025 at 01:51:59PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 02, 2025 at 05:44:56PM -0800, Charlie Jenkins wrote:
> > On Wed, Dec 18, 2024 at 05:52:24PM -0800, Charlie Jenkins wrote:
> > > On Wed, Dec 18, 2024 at 05:20:15PM -0800, Ian Rogers wrote:
> > > Yeah I agree. This test case did end up being interesting though as it
> > > unconvered this change in behavior of objdump on riscv, but that's
> > > tangential to the purpose of this test case. We need this patch on riscv
> > > to stop this test from failing, but it is also reasonable to approach
> > > this differently and not use objdump at all.
>  
> > What's the next step here? Would you prefer to get rid of this test
> > entirely? I sent out a v3 that uses uname [1].
>  
> > Link
> > https://lore.kernel.org/lkml/20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com/
> > [1]
> 
> I'm ok with this latest version and added it to perf-tools-next,
> changing the patch subject line to:
> 
>   perf tests code-reading: Handle change in objdump output from binutils >= 2.41 on riscv
> 
> Ok?

Yes that is perfect, thank you!

- Charlie

> 
> - Arnaldo
