Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76958569F22
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096383; cv=pass; b=EoRvGDUbdv7qLQguQu78UBC+tdOyuzy78XBBG3D4+eD5c/lIOkqZ2wF/6Dk+U4+rCbSzDqcxi2Jgj0zRaUTvNbJaiPwC+yHiC/IXncJxU7H3kvJ5bNu5he6QBgOuBB0KtFMdpdJkJoEBKbt6Q/C3SoSC9IHtfOQsYHNRVtKdsTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096383; c=relaxed/simple;
	bh=LRn3GFzuUdLoBRg+/HP+f5teFv/89kmI0cipOvvuRfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAFG/WTRrpq6DpI/0a7+p9AFjIwVYGZxZ6J/cdgqeXEj/CEOHT7SwppWsDkQ38l2TpFlQBB0M6hkNdJLNH4Jgs5WXw9asrCQmtLupHWHlCaE+UD3et/YV0ZYPP56WFWaZAOZRSlKHtN83A0Zes4EscBrClW9WOcd5kJ898uP/84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGoBhlVO; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGoBhlVO"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52faa58bff5so4271cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 09:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096380; cv=none;
        d=google.com; s=arc-20260327;
        b=ZXHz5NRv0fLiCCO4Ny5X6U43zYDpengBFBB06i1SzRJHJxCIZpRis9lQCaejsju3zG
         rIKdBuT8vYJzkZer7mt+TXAagBCX5js8mshrCefutQ/69SqxO4jbHgzhmoxR6uoSTQJS
         A64jlJ7RMZF6oRV/f5pAqiFhgaH3+qZO/IV4ty7jP7HbZpSIZlXNzlBXf88d8E9H0EtV
         bvoJBZ97Eb6DbqyqvC9Z5sRFpUFlXqLt8A7aIW5yZD8VOcs7TurjRW5bsRdMD9eYqR9W
         158C98mben3wAa5+9AEbIiSamBxziS5lZFOU78nKFjgMCXLCjuh4zuCiHXGw83+IC4oO
         hogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HsqDw8925+XtaD9Vzbpc0jDahGyyPw4OUMTbUv1Lnh8=;
        fh=qvBkKDEHZuPFGeX1Mhs/LFu42MszVCtT81lRR9WHyx8=;
        b=atNok3YxyPM4HbDfu+idw31AQ1f95YbOsWdPRkRbggzugmJzPng0CNXuZkiYdoQXzS
         qrNEUM+QFxqPAo6f0CmdEYGe40Jtng2QBKef386gpiDAljD45yw5q0BjQuEolYcWfemk
         NGbX9HWnmweIvxf3Cd/C90Eyc2vfTf+TdvmQREaO5vgZyBsE6eZ1lCoxjG8OG0O4WEYP
         6vbu/cyK+bINjdK207YR+aJxCcZ1kbNb5gGiTqQuO0Kfc9NGXmnUrbKAu5XyB81RFSMy
         xkerB7ojZK+9lYhzTKLB5p3jOhYIROTTDvVvmOwemSicPXc/c/cOw9gjDst5BlIqLaV0
         ucyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790096380; x=1790701180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsqDw8925+XtaD9Vzbpc0jDahGyyPw4OUMTbUv1Lnh8=;
        b=rGoBhlVO0Jd3iktSiyOPyJu5xmKomRHa97tUnuj1unnjBd2bkchOh3UqkZx58TX/Vd
         O3XWqKK6qjdmcvH7ghod6BEV7d7ejB0RywJwzCJs+OlGPw6nXTXChxgUlKROB5P3NVsu
         UkxIGuQrkj0SF+++8MQ2uZjSbxMnfPF1IllaqeYRhPLXzHXTZslFie9d+bJmZsPkZUEf
         pRNIqIVh/sh21AfD/QU8JlvYA3mpst9IHY2zcPsnHr2rcsvkLE79uwwqs0urYw5DYavS
         MoDeV26vPSxxM6fhQ4lnpncU1yhX9y6CWxYlJWbIDSgGHnRdOZdIaVHE+O+TbAxjNLI2
         YSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096380; x=1790701180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsqDw8925+XtaD9Vzbpc0jDahGyyPw4OUMTbUv1Lnh8=;
        b=a7/vuAre05SMic6x/gsWhGrLTEK4e5l+YUQ8voAnUvQ0p5EArPH6E/yS/lnUEj459a
         nBb68wUxcHNfr2vPtEKkQT0kJZPKYw73Hk4+fiJORzrYZqU6aJSY/xmYOjQs7jOEpB2Z
         2gEqTvJhto/DMLs1zMOVMqGck7BBtcvF412bGw3b3Pi8XWZcmm7nRLsio/VPINTKPmzT
         ulIUGp++ww4t+f+PqwgfzlLYg0rg+Y2zuzpTpNzgE321N68yRE6PhljtgEe288UT1x5p
         XjPHUxl31Kd8wiqd3y86Aqz2FL3sc431oYwYq3VOCMub5A8zcVp5VczDXtRTZNmEL3zc
         79xw==
X-Forwarded-Encrypted: i=1; AKwUvBzzAjBfh5RM05EUb2UgGiHiROJWsp00AwPaPjzZ4zr/N9RYOS9/RE6uACfJVXDD9WUhiDsmHnQ4ltlyhRRCIfiO@vger.kernel.org
X-Gm-Message-State: AFuF++lURvMtUWWg/uMLTkzmw2uv6CMPsOgLhBmF9sqtRdGpjog+WVJa
	U3WTJZKguoN/K5a7hvtFwKM6rgrdpZ+6XvDyWBvJVyYstVLNnqDw0qJJ3vJ/+HgJpmA02krp0FV
	IdrX5odP3Pf/jPmxZiF0acTUUC35G/tDd7aIXRBIT
X-Gm-Gg: AYBFou2BJQZv+LK4JRnugQ7CsAUPeruGyo/Y63APnhigtObeduQNjxq/yYBaLKM343O
	K/ylrndLj0S8fxlUM/2Bnc666jAPIW+u9EANg/NI8wEM8THKkcezCLIVmvJSAR3eCytdVPGc2nC
	YuJ6O9/E83sTvXco74bjJdPOUxCGTkAGNz0h3VPIvo5hXt00NCyBmOeN/7qrp6uA7nXGN4pu7qK
	JRT1Yo4Ca9mEclocVbnlbV1b11ClJP3DhCCiRSXLEqwNI6wU920Z4wysmsZMY5wyuOQ4c/Jatqh
	xOqzqCMFlpLScVA+66HuVspUwDCOjfqUq4KGwp+TS9Xac2dxaeKkX5kp33d+u0R8EHYbiEOhXV3
	vb5FbOSY=
X-Received: by 2002:ac8:58ca:0:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-532e8669213mr4171531cf.14.1790096379504; Tue, 22 Sep 2026
 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <7c56d15d6e61fabe8b94f5a98713305f15bf0848.1789966896.git.irogers@google.com>
 <56ea4b35-f73f-4e6e-95e4-f255eb089c5c@linaro.org>
In-Reply-To: <56ea4b35-f73f-4e6e-95e4-f255eb089c5c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 09:59:27 -0700
X-Gm-Features: AcwNN1Wxe4iKMPSdX4ghjuoW7LHjABByJQUuMgDPKi-P4xHVkR2Yf5ncUcs5YLY
Message-ID: <CAP-5=fXF=7AHVm2wKqvtFcQ1byc=-4kKvLb_1dQkge4tcQjX1Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/49] perf build: Make mypy build test opt-out (NO_MYPY=1)
To: James Clark <james.clark@linaro.org>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:11=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 21/09/2026 06:06, Ian Rogers wrote:
> > Commit 168910d0f937 ("perf build: Add mypy build tests") added mypy as =
an
> > opt-in compile-time check (MYPY=3D1) because of existing mypy errors ac=
ross
> > perf Python scripts.
> >
> > Now that all Python scripts in tools/perf have been cleaned up and pass
> > mypy without errors, make the mypy build test opt-out (default on when
> > mypy is installed, disabled with NO_MYPY=3D1), matching NO_SHELLCHECK=
=3D1.
> > Set MYPYPATH to tools/perf/python so local imports resolve during type
> > checking, and clean *.mypy_log files in 'make clean'.
> >
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Is there some minimum version or other setup requirement? I get this:
>
>
> pmu-events/amd_metrics.py:181: error: Unsupported operand types for +
> ("Event" and "object")  [operator]
> pmu-events/amd_metrics.py:182: error: Unsupported operand types for +
> ("Event" and "object")  [operator]
> pmu-events/amd_metrics.py:230: error: Argument 1 to "d_ratio" has
> incompatible type "object"; expected "int | float | Expression"  [arg-typ=
e]
> pmu-events/amd_metrics.py:231: error: Unsupported left operand type for
> + ("object")  [operator]
> pmu-events/amd_metrics.py:236: error: Argument 1 to "d_ratio" has
> incompatible type "object"; expected "int | float | Expression"  [arg-typ=
e]
> pmu-events/amd_metrics.py:236: error: Unsupported left operand type for
> + ("object")  [operator]
> Found 6 errors in 1 file (checked 1 source file)
> make[3]: *** [pmu-events/Build:192:
> /home/james/workspace/linux/build/local/pmu-events/amd_metrics.py.mypy_lo=
g]
> Error 1
> make[2]: *** [Makefile.perf:562:
> /home/james/workspace/linux/build/local/pmu-events/pmu-events-in.o] Error=
 2
> make[2]: *** Waiting for unfinished jobs....
> python/ilist.py:13: error: Cannot find implementation or library stub
> for module named "textual"  [import-not-found]
> python/ilist.py:14: error: Cannot find implementation or library stub
> for module named "textual.app"  [import-not-found]
> python/ilist.py:15: error: Cannot find implementation or library stub
> for module named "textual.binding"  [import-not-found]
> python/ilist.py:16: error: Cannot find implementation or library stub
> for module named "textual.containers"  [import-not-found]
> python/ilist.py:17: error: Cannot find implementation or library stub
> for module named "textual.css.query"  [import-not-found]
> python/ilist.py:17: note: See
> https://mypy.readthedocs.io/en/stable/running_mypy.html#missing-imports
> python/ilist.py:18: error: Cannot find implementation or library stub
> for module named "textual.command"  [import-not-found]
> python/ilist.py:19: error: Cannot find implementation or library stub
> for module named "textual.screen"  [import-not-found]
> python/ilist.py:20: error: Cannot find implementation or library stub
> for module named "textual.widgets"  [import-not-found]
> python/ilist.py:21: error: Cannot find implementation or library stub
> for module named "textual.widgets.tree"  [import-not-found]
> Found 9 errors in 1 file (checked 1 source file)
> make[3]: *** [Build:91:
> /home/james/workspace/linux/build/local/python/ilist.py.mypy_log] Error 1
> make[3]: *** Waiting for unfinished jobs....
> python/treport.py:12: error: Cannot find implementation or library stub
> for module named "textual"  [import-not-found]
> python/treport.py:13: error: Cannot find implementation or library stub
> for module named "textual.app"  [import-not-found]
> python/treport.py:14: error: Cannot find implementation or library stub
> for module named "textual.binding"  [import-not-found]
> python/treport.py:15: error: Cannot find implementation or library stub
> for module named "textual.color"  [import-not-found]
> python/treport.py:16: error: Cannot find implementation or library stub
> for module named "textual.scroll_view"  [import-not-found]
> python/treport.py:17: error: Cannot find implementation or library stub
> for module named "textual.strip"  [import-not-found]
> python/treport.py:18: error: Cannot find implementation or library stub
> for module named "textual.widgets"  [import-not-found]
> python/treport.py:19: error: Cannot find implementation or library stub
> for module named "textual.widgets.tree"  [import-not-found]
> python/treport.py:19: note: See
> https://mypy.readthedocs.io/en/stable/running_mypy.html#missing-imports
> Found 8 errors in 1 file (checked 1 source file)

Thanks James! So there are 2 issues, and I'll fix the code in v3. The
first issue is that in older mypys the join the plus operator isn't
computed correctly and this can be fixed with a type annotation. The
textual issue is resolvable by running mypy with
--ignore-missing-imports.

Thanks,
Ian
