Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2/rlFDh"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31318D
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 13:14:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50beed2a46eso838e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 13:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701724475; x=1702329275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC3Kqwq0MMmfCoFQwZgAsJVop+/+8BNQbF/H1UQSrUk=;
        b=J2/rlFDhgONMIXUDqpLdS4TQWKgnZarLU0gr6cz+RN8nkSezO7l1iXgTt6M6IxsokO
         3adCAlWhq3jMoD2XHdSFGZ4cE5S1EECTwjhoLR0ssOd6FKa7uT3+rZ7rW8mmxwPH6fJ1
         TdfIPWLG5SiSrjnjtqNAu9Z+Iq/GkqVuwnuZ2WnJfO8qAIPM/4btBdMHCqqbmRX15iRy
         ET9wM4cVKtBV/U1cbMlcUwuz5vSbPk3ulBFcykWZfIu3kw0DhyQQf5955SQOEUlD1sYu
         /t7+pHNwMq5amjzQAdrS2RxF2sHbtFN80Sulii6vGBoxx5OhDiTiC/71MvfXnYg6k8m3
         koTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724475; x=1702329275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC3Kqwq0MMmfCoFQwZgAsJVop+/+8BNQbF/H1UQSrUk=;
        b=Hke+W/rmzOYywSByJSTpLpeGa6KX1aGLv7iG0SPAIgcgHIjFKsXkDeADwMqUcgLed9
         RthSSgVlARYjNK5c/i23Bh2UdSTEJ0atHGXOfsMcZmbit15w0ifUwDg2484jrmRFgJi8
         bk/26d8QxDqfoQ3Ms2Gf2bRFIRig33JxcVcnOPwQ2Tn3RjHh+Fw7g8BRDVo3T84fVNdZ
         rcqhE8CoOSqPwuXIpRWpY9ah562rqTHAJvCMjoirpHw4tXNfK76NuqrwnT6+dOIoAR/n
         N45f3clJ7XAKjWQU0p+P9CZj5Y/ryvwFnbzs4NJ+R43zdetuxmIf1yuW/zp2s/YCMr1q
         63+Q==
X-Gm-Message-State: AOJu0YwYtyAZ/qwHCXyX+HFrx6usxZOFytL7LP7fDGFo3xMA2zWksdws
	rrI2YcI7zDkMzf8JiP6/7PpgBBJk7g3U0MXHjpMBPQ==
X-Google-Smtp-Source: AGHT+IHFNQl9WEbRcWJgH4WIhG5b7q61jmODDxGI8iaboRfnh21mH+fe1Ktul9AFsgSTRW5UVuMiGdR5g8dxC5LoCTU=
X-Received: by 2002:a05:6512:12c4:b0:50b:fc76:42c with SMTP id
 p4-20020a05651212c400b0050bfc76042cmr87811lfg.2.1701724474909; Mon, 04 Dec
 2023 13:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com> <20231201235031.475293-9-irogers@google.com>
 <CAP-5=fUtoi7ynQ-x_7rrv_vYoTZfS_14COA1MskOFVXJ_jCDew@mail.gmail.com> <ZW420ecpaSjwykny@kernel.org>
In-Reply-To: <ZW420ecpaSjwykny@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 13:14:23 -0800
Message-ID: <CAP-5=fXq2CTwSO8QVRdgz2uR73DrGU9qD3z5gPPD3ZEncsn36w@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] perf tests: Add option to run tests in parallel
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 01, 2023 at 06:06:12PM -0800, Ian Rogers escreveu:
> > On Fri, Dec 1, 2023 at 3:50=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > By default tests are forked, add an option (-p or --parallel) so that
> > > the forked tests are all started in parallel and then their output
> > > gathered serially. This is opt-in as running in parallel can cause
> > > test flakes.
> > >
> > > Rather than fork within the code, the start_command/finish_command
> > > from libsubcmd are used. This changes how stderr and stdout are
> > > handled.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Actually, I think this patch needs more work. The verbose output is
> > degraded and missing in some cases. Suggestions on how to fix welcome.
>
> I'll think about, but to make progress I think the first 8 patches in
> this series can be considered now?

That would be great. Thanks!

Ian
