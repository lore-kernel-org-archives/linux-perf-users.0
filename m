Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B71FFC4F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380674; cv=none; b=DcVl+D7X6/wxOUOaFiJrBk009x9IISnEwp7ePwBQBCDPtZhmRpZdotg4myXPRqUbveEk2/mewOnnrEvB5F/A14VaDVg+FIE2MDIAOcHHJzNv98/pq7J3X5yvWWr25hulevyy8ZzwSoMUJpy5O9bvXW5iLQxuX5FnHClkBpxBNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380674; c=relaxed/simple;
	bh=B+99Rf+2I0jJZmtcZn+WFPEjXE9UraGmIhuRA3//flg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf3hOSlxhOtqMZyo3nD0qfs7EcurKGu6vJkaxKR68xFcrHZdU1j9GA3df/+lgEg/k5Kr6lG7hxrSXcNrv+jC22JfgvtttTFFdCP5bGa2OZ5Fztc59WYv2DIDUgONyeLZSIpsCtEM1LzvwkmcMCUr53gLBmyjmpETQU75/9DhMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4piLsp0; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4piLsp0"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso23305ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748380672; x=1748985472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+99Rf+2I0jJZmtcZn+WFPEjXE9UraGmIhuRA3//flg=;
        b=s4piLsp0ZE/jWrVrd0JEBdXJUC4lAI/1ER/WDxrDVCdNtc578gEcubwkh/R/ls/Rum
         XDwgQo2vP6eD9Z/gmXsVXJwsPTbcI2Cv8krgZZk55m7B31TS5orPIJoEn/Sm6KJuHx94
         eE2tfqJ9fTW4n47g3yjnM01OQh3FHrd5EHWGRftcsJvTTAEmq+W/pty0wr3tsC5r/3Dr
         mX9mu89/zLYUGJQIeEmMR9pjxFi2s2+zqiN0WER4q2E5LNnQVEPVsUGyWET+ilBJzybT
         +iw82jg1ZJh0syVIk/Xt5+sNw7Ng00Zz+WeYKSiauxlJ1mmmSbew2LssZJ+nLUSDZrlv
         NI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380672; x=1748985472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+99Rf+2I0jJZmtcZn+WFPEjXE9UraGmIhuRA3//flg=;
        b=ZpJFZqY+4kKTOAaiCLU9umw89jsIIyoaNXsoIDSOgshttEybWOPrb0bFT7e414iS+a
         /PNrpyW1eqXqSf0NQOcLeFxo2L6qoXnl9Pg8Ykg7UFzkO02Xi56VK15EduZuZbXqVjbk
         m0uzJPeBFhiXwfkseCPhEpAQtaLCTFPLlqh8zR+3Qg2g8kbYokrl60H8n/JRLcbpGnJU
         YcbOV3OXDfD2nEsyTv5jyQz1nikDKNaT3vI+gl8waWb5++oi0BpK9UzTSvxxQzL9veuD
         pI2j9Iu6DQQLDl7HEeZIX7KyFIOGz+NPnJo7nSWyA6V7y1WNc5/zc64KcB3oav8/mCPv
         k9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVooEng7MR/wk+zuUC0rG01fSf8F2Le1KcMS8I3qCdAkAzyghcpAsrg8un25VrR/11GvMQ1ctUabmSqLUu/gQFi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7bc49fLpnNLVo8s4Eah/Q51l4IuHRMYD9czIocS9mB6jp9Gu
	rmdzmVEmYmISEXCc+M4H9EiGxdDDZT1e5xnnR+lbne/Pbb6aqliG/ty7YCPX4eoF719BibD1urg
	6g3u6gApNbl9GNEBN6LMhf8H56tZWBlPlGmWaIfGD
X-Gm-Gg: ASbGnct+nvcfOBJ72f8D3Z+Txx4uMafZXEYijHd3HQG61k34W7eEjAgIdQZjm/V7Dkh
	Dq68h/MZ/+chHBg1NgFK76nvsFXHE18ntsd4RHKPNR0kRaptbD2AZIe+lNeG2lrADl4yb34diqD
	/batqBCwnLROn9FhGibJiq3Brzn0UR+1AcGl9Fi2Y3a+6Dq1E4s5/VSBVmVuXea7mQMZToZCXI
X-Google-Smtp-Source: AGHT+IHAuT/+L6BfBHpTYTb+SvZlo2rWXr6bkvbj/lWrD9rlW9tNhusiOjmF5tsFCXH8qEfKNkAYuNJ3s9Zd++Z2CWk=
X-Received: by 2002:a05:6e02:178f:b0:3db:854b:9f52 with SMTP id
 e9e14a558f8ab-3dd89c52111mr361775ab.7.1748380671633; Tue, 27 May 2025
 14:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313052952.871958-1-irogers@google.com> <Z9Rk-YdoK-fK_62d@x1>
 <Z9SK96s4PAp680k6@x1> <Z9SLL50yuiLOGGYI@x1> <Z9oGI8G3cOoluIKf@google.com>
In-Reply-To: <Z9oGI8G3cOoluIKf@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 14:17:40 -0700
X-Gm-Features: AX0GCFvPUNGmSlZUOtr_MrctXEr7ggvsEHiXnYCnz1_Q4SqywMc8Qv_Y61_aDuA
Message-ID: <CAP-5=fWaTU7Ouj6ZnF2jaoiQbT_Niavx-JA=_bMdYRsr7T-P8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf machine: Factor creating a "live" machine out
 of dwarf-unwind
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Howard Chu <howardchu95@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 14, 2025 at 05:01:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 14, 2025 at 05:00:58PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Fri, Mar 14, 2025 at 02:18:49PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, Mar 12, 2025 at 10:29:51PM -0700, Ian Rogers wrote:
> > > > > Factor out for use in places other than the dwarf unwinding tests=
 for
> > > > > libunwind.
> > > >
> > > > Testing with another patchset being reviewed/tested, seems to work,=
 if
> > > > it showed the line number would be even better!
> > >
> > > But it gets the lines, at least in this secoond attempt, after applyi=
ng
> > > Namhyungs fix for the previous problem (int16_t):
> >
> > Nevermind, this time I built with DEBUG=3D1, so DWARF, probably.
>
> Can I get your Tested-by?

Ping. Thanks,
Ian

> Thanks,
> Namhyung
