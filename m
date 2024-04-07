Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870F3D3BA
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Apr 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712514767; cv=none; b=gTK8C4yk7OtPflac/ue3JHpycx9LMXrJtZQQCD40QsAFbRQ12XdfsIdhruIny978Iv0OTq8cODjxop1VKYAGuYZxjizRyDRrN9TmhEng4pvVUP2LuU77fit6o67v5Hh8aeQTG89ClGwKwBiZooPYjHu5fz6adeH4rwP3Aq72YF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712514767; c=relaxed/simple;
	bh=ztHnNx/SQUL/wwuwHRpMPiRVSAVPrQTfiIVmDy7B+jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7cBeoB7L1lTx+qr2NjxIyWsSNy8NlxKGq5aBPm1slNSy0b55Nlyj7TuSPi7kx9SKBhEPsQm05drqkPRYnMi9GXhCZURc2zXT32QjWvxj3DF6kFxl6yfO/mE6D7RLKElxT7N6oM5nKzbbZDWP0u06Z+vhW5kYydJDBHUWadANVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0ws60Lq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0ws60Lq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c89f3d32so156275ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Apr 2024 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712514765; x=1713119565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLqjjjy5BIBpzS1nANECMi7hVdMwuO/IpZycBkQpgS0=;
        b=N0ws60LqS/uXI5sgK/zPm6o1eyGkFkIQs2EwwM8woaIKJgGWGbVJ5OV3JMKVP3BXey
         FHJ5iwLE5Egvb2xAYyu2LqutK5O2hYy9/IYAcx0I6hjIZZxLypcmu4b9IaRf4CvbUwu9
         YVI5qWpnqMmTfPXwJfHqmRTyElYdBqJwCSGSnLtPWnbkpjsqC8bJxukjkSDFNGxEDF0X
         n1vkgeNYEiYzG1pFVb2juCvoGutIU7aL9A2Um+8VNH5IWT6RPMFFfYP9+A4JgPbF2RtK
         XXDC0TkLWIoWsaYkNx8pjmszep0gIsJOsOaQVr59lf2vCxpPvsslh7zZir7YI+aYpHBE
         yT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712514765; x=1713119565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLqjjjy5BIBpzS1nANECMi7hVdMwuO/IpZycBkQpgS0=;
        b=QlBoSkvuEPpIbxMtS03VaR3EKq8xIxxxiTyNbq8bkGzoFcBS3dFpZm8MDge2GXOUc2
         9dE304lVOklRftO7bJvN3fZuAt2OJFMn2S5CuDU6s5RdbSxUwn1tR+axbf12ESaEyIL0
         Uzz2B8xMTasofNfai8iuwDGks8D6loAoBUil3pg6OQa9836kTtyVnZrA3Ss5FB4eUAAs
         +jE8YOkBJsettrcsmAnuQUrYrNVqfzW2S4yxGZ0xFda+XpyMW4/2Iuzf+CoeZsDvJmL+
         tGhHfEaGDxwAqKlpy1Etzoa/hkx6vMNAXc4nW2fBew1GIAjXTY+pPArSmDapC22Az8KS
         plsg==
X-Forwarded-Encrypted: i=1; AJvYcCVHtXyaaZ358RgLnOc5pjKPNXFbHpNbH8zlKBhSUlSon3cGjVnYUY5KcQhU9dmHxRQP7iHzK3gO0hadsi+T774eQcJakLa9mN0RE918s8BCbg==
X-Gm-Message-State: AOJu0YwJ/qpQHz+IDmLrfY4Vz+/46Qf9ipw952Ir6etQmKGdb9/8xpag
	mvQbM8XF5Y+pp/F0BGBVL3wqoGk0isXtALRC1wxk3cnMaG/iA3LYwJF2UqAa5KixSbwDSJmXmOE
	CBG3zs4+m/dDjLTA5INnwujt7czz4fLnfuJPN
X-Google-Smtp-Source: AGHT+IFJVydgcdM1xx89HGIXg/sm7hAU4b3TmyPgCj29iXcoepIXFDZtzFe8jWiNvQAUJAbfsMrh/qPjYSNKJohaHgk=
X-Received: by 2002:a17:902:d2c1:b0:1e2:29f3:aff1 with SMTP id
 n1-20020a170902d2c100b001e229f3aff1mr178307plc.25.1712514765171; Sun, 07 Apr
 2024 11:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
 <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org> <ZhKTrUPbUnBviQYK@codewreck.org>
In-Reply-To: <ZhKTrUPbUnBviQYK@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 11:32:31 -0700
Message-ID: <CAP-5=fWT4=yT9rxKmR4ing9i-EffRQnjTP355wU-fFN1Mfnezg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf parse: Allow names to start with digits
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:38=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Dominique Martinet wrote on Sun, Apr 07, 2024 at 09:18:21PM +0900:
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index e86c45675e1d..41c30ff29783 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -158,7 +158,7 @@ event             [^,{}/]+
> >  num_dec              [0-9]+
> >  num_hex              0x[a-fA-F0-9]{1,16}
> >  num_raw_hex  [a-fA-F0-9]{1,16}
> > -name         [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> > +name         [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
>
> grmbl sorry I guess I didn't actually test this two years ago (?!), or
> used it differently (commit message is weird and also needs fixing,
> perf probe -e 9p:* does not make sense) or something changed but
> that's not enough:
>
> ----
> $ sudo ./perf trace -e 9p:9p_fid_ref
> event syntax error: '9p:9p_fid_ref'
>                      \___ parser error
> Run 'perf list' for a list of valid events
> ----
>
> Adding 0-9 to name_tag as well makes perf trace works.
>
> I'm not sure what name_minus is for but I did't need to add that one in
> my test.
>
> That also highlights that the test I added isn't sufficient, if someone
> familiar with the code could hint at a better place to test please tell!
> Otherwise I'll have a look next weekend, I need to get back to my 9p
> bugs now I've got a working perf command..
>
> >  name_tag     [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
> >  name_minus   [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> >  drv_cfg_term [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\.:]+)?
> >

Try adding PARSER_DEBUG=3D1 to your command line, I need to do the followin=
g:
```
$ make EXTRA_CFLAGS=3D"-Wno-error=3Dredundant-decls" PARSER_DEBUG=3D1
```
For your example it seems to parse with the changes, but I see (which
should be expected):
```
event syntax error: '9p:9p_fid_ref'
                    \___ unknown tracepoint

Error:  File /sys/kernel/tracing//events/9p/9p_fid_ref not found.
Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feat=
ure?.

Run 'perf list' for a list of valid events

Usage: perf stat [<options>] [<command>]

   -e, --event <event>   event selector. use 'perf list' to list
available events
```
I think Jiri's e-mail should be jolsa@kernel.org.

Thanks,
Ian

> --
> Dominique Martinet | Asmadeus
