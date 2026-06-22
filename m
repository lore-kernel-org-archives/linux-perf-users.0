Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5A33EAF9
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152276; cv=pass; b=D543PcPxN9GCMe10+g2df5e3t1oBmzqiPigoZjWkNbzYKlpc6gkEL7FWbes0HInBVpvtTHMkeMat4amacD+CaI6DmWNGAJ6eRQTZHhXpxbycImmCLvmwbRB96T9dxEWVBWJPcGal149qEZwxwSUj5lVGtrxlX3f0Z+AnGC+c5Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152276; c=relaxed/simple;
	bh=m11RxMrybFbYq1aegOwyhpbXAUpIQLIK+I74ptbAttQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVazkOXTIn8gyXdoyXj4eBOLtPW8ROrSyl6EW4QIQJSIgQrtzsOwylGclD74wNgOMtCC/cczttstaz/VNEMcMiabNgNU3h6ElOGNpwaT9BPP14TAeIc/Y2L6ro+DzK7QuqMf4cptYRwt4MnRB7JV8w154TAdpUfb14d+cWUr1V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFC+8vU4; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFC+8vU4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso5955ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 11:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782152274; cv=none;
        d=google.com; s=arc-20260327;
        b=Ugd84nGC3/kLJozfF8J66ECv+1qA/21IoAtPAPnEm4d+7yWaDG1ERslWLeoFvILfZY
         rOpwEW6oRyujuAr39AxDdqRy7MiP87cAq2Ik5alXDjkMQq8pyMZqM0NGcYjjFuMMtGT9
         rlydp9zpbmR5fSnEzowZLdMk0lOknmpEDpMWdmrV0Or3RcjtdBbPtIs2++PXs5sx3Y1h
         +cd0FRCmWM/AR1iYh7BbzR5Yk5O50MipLesDr3xX318uOPSOZqa1qn6VGBg6eEuNggo/
         gTmPGQCe2yX9WdyAprAmNPXWa6Tc/4WLthc5H10plrHMNo+s4YCAX9vvPJelG0hzuNqX
         5CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        fh=RE7v2lIzuaEZ+NODFtxqdkdFUzMEfiO5ZgljgGFmpAY=;
        b=S0lvlqMFsyIH9Q18VXozXIDTlCnAW/C6Qg1aHJc4IqrQYxNGI2+lYlr4KOwp7R3HCB
         CbjEHTkWYdZPgPbaDMT/1Mxl9vJA3BMDVyQTl0ssLIViWjegHh9nv0G8mg+0cX7PHIrG
         5HkP+KrWR+IAvMMbMNLl77tG+FQOxj10j2zAyWhapHBmbU8A16snT6o0LKS1aS1uFzmb
         aKsJjRqtN5WOerC2tPTQCG3uX+2qXcRYicKXY2aOzvdF7r2FRnV3QmJBs9jKxBEAntqV
         jSzx7ZqNmT3Fn75/hRoKDUCcXQVFHQ381Nc+JImdOnjqaddcnhU+kNn7JsqKPWvxF6fP
         ylBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782152274; x=1782757074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        b=rFC+8vU46fBJHk9Al1hIp1OoWQ0dZf0zu0KH5BcwuwahChM35DhaGEhl6eF33pCkoa
         wLhSrKmBj+QZxJE8yhj3xLIhDW9etj7v7ASkkCeR2l+QVJ5IEvvReyHKImAaL8AYP+Bs
         TMWtngENOkmoDJPnIMrh/sDwxV1ZObK2Z/7auwv2sKRYV3mw5FYVjrDoTzfB0tw2f3vz
         r2LgYHQ0Iw3dj0NYA9s30mk2YOuwlQwQl4I87wJWQi0g6IJ7rhIdUWGvble5FZrGU4Ds
         h529j+uXs92BB/Sa+Zx1CJ8K72B2K/pXZfdHwJwLOkcPwElJeliAmDwCkDBymB7+O7QZ
         c0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152274; x=1782757074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtFt0nsYRVxh9pjtBHg13JFYnpuDwE2MjabpRY6kgzQ=;
        b=j7zoc1jBGuCt6q8rJtWMSR78UJ/WOJrYQvgL0UtBhPX8FDh7kjK6yIOkI5pe/D/BWy
         88zUMXwJ2FtU+SJsRBA5WBCWsfL+tCH8wyKoO6+wkh9gINUbEIP2aIgInFY6dSWBEBsL
         7jtw+mmKK4VjNtjcnMw8eyzsWuOa0vIt0sSjRWkDM9iKSAsHOV997Quv/Ti/P2ZcrImL
         zh8b3evzJLl6Z5Bu8kIYx9GkCYO/4l/T3h2HX2O5A2d50SuY2kPwbAdBY1s6JuH7Wyqr
         fqpT9icBUqj6XBbRPNBimDfWeAKzcF9KKtJB9mh6pV88ZwGi7+O30Vy8LVh1mRwTcbDO
         m53w==
X-Gm-Message-State: AOJu0Yx/E8eNZ9V0X21YykD/FmqHo7iZSxL0oO3DPfjfO5/3cVC2Aoym
	Ask9U6WrAkwiDqCzL0/qzn+scUaM0oJG0ytYGLcXXutL+gY9yYn0Jh3z9+H8C95Zq/I4UZD5+E9
	eCh5AiqKxw5fUIYlhCdXbM25nsIlXHDGql+JizFaj
X-Gm-Gg: AfdE7ckltVUmoLQUCHgPcZ+FMeuLHgvliNTOlvBh8u7IikRtCXsb4yA9rp6D7J1nRoU
	/FZ4v0YIbeo4mwV2wIUfV48vOUXv0aBuFA6LM/TP966IXUzzPrmcCk3Pvoe2xY01kV/KD2H386x
	8T/c9mdYb/WDsHbOoLdoOfWZNUNrU6wutaPTeCkmLEE0Pu99KrzWUbRM1FjBzTqbFpb6xWd6+PI
	ygvuoDFLROhRCE7voWDDrqbCeP+1sLX5indGLxC0/b9U69ivV8fB/tnqf56AfdyvF4lsWTPMA==
X-Received: by 2002:a17:902:e842:b0:2c1:ee6e:4e4e with SMTP id
 d9443c01a7336-2c7c55c4688mr220605ad.31.1782152273465; Mon, 22 Jun 2026
 11:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619093531.4038655-1-tmricht@linux.ibm.com> <20260619094233.CBA9B1F000E9@smtp.kernel.org>
In-Reply-To: <20260619094233.CBA9B1F000E9@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jun 2026 11:17:41 -0700
X-Gm-Features: AVVi8CffVrqrwBpGjIxgkJVAl6Ad7IfgqkmawX297zMXF4nP1v65i27NURFYVVM
Message-ID: <CAP-5=fUJbh=dXiadCJJ4d_prCxox1G0WW_WODwSHC4DvwWuQag@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf test: Skip failing 'perf test aslr' test case
To: sashiko-reviews@lists.linux.dev, Thomas Richter <tmricht@linux.ibm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:42=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditionally setting `err=3D2` when skipping `test_callchai=
n_aslr` masks prior test failures.
> - [Medium] Skipping the test incorrectly triggers the test failure cleanu=
p path, leaking the temporary directory in `/tmp/`.
> --
>
> commit d772895777a1677561d1802ac157c32ce73e1379
> Author: Thomas Richter <tmricht@linux.ibm.com>
>
> perf test: Skip failing 'perf test aslr' test case
>
> The test case 'perf test aslr' fails on s390. This commit fixes the failu=
re
> by skipping the subtest test_callchain_aslr and emitting a hint when the
> --call-graph dwarf option is selected.
>
> Fixes: 60bc9fbc0589 ("perf test: Add inject ASLR test")
>
> > diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/s=
hell/inject_aslr.sh
> > index c00461828ea79..7fdb43679dc84 100755
> > --- a/tools/perf/tests/shell/inject_aslr.sh
> > +++ b/tools/perf/tests/shell/inject_aslr.sh
> > @@ -135,8 +135,15 @@ test_callchain_aslr() {
> >      echo "Callchain ASLR test [Failed - no noploop samples in original=
 file]"
> >      err=3D1
> >    elif [ -z "$new_addr" ]; then
> > -    echo "Callchain ASLR test [Failed - could not find remapped addres=
s]"
> > -    err=3D1
> > +    if perf evlist -v -i "${data}" | grep -q 'sample_type:.*STACK_USER=
'; then
> > +      echo "Dropping stack user sample as possible ASLR leak"
> > +      echo "Call-graph dwarf not supported with 'perf inject --aslr'"
> > +      echo "Callchain ASLR test [Skip]"
> > +      err=3D2
>
> [Severity: Medium]
> Does unconditionally setting err=3D2 here mask prior test failures?
>
> If an earlier subtest fails, the global err variable is set to 1. When
> test_callchain_aslr() decides to skip and assigns err=3D2, it overwrites
> this previous failure state.
>
> Since the perf test framework treats an exit code of 2 as a SKIP, the tes=
t
> suite will report the entire script as skipped, completely hiding the
> actual failure from the prior subtest.
>
> [Severity: Medium]
> Will skipping this test inadvertently trigger the test failure cleanup pa=
th
> and leak the temporary directory?
>
> The cleanup() function in tools/perf/tests/shell/inject_aslr.sh explicitl=
y
> aborts deletion if the exit code or err is non-zero:
>
> cleanup() {
>   if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then


Thanks for the fix Thomas! I completely agree with what you've done,
but it exposed this latent issue that we should make the exit_code/err
comparison -eq 1 rather than -ne 0. Perhaps Arnaldo can fix this, or
we can address it as a follow-up.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>     echo "Test failed! Preserving temp directory: ${temp_dir}"
>     return
>   fi
>   ...
> }
>
> Because cleanup() was not updated to handle the new skip state, it
> mistakenly treats err=3D2 as a test failure. This unconditionally leaves
> behind the /tmp/perf-test-aslr.XXXXXX directory every time the test skips=
.
>
> > +    else
> > +      echo "Callchain ASLR test [Failed - could not find remapped addr=
ess]"
> > +      err=3D1
> > +    fi
> >    elif [ "$orig_addr" =3D "$new_addr" ]; then
> >      echo "Callchain ASLR test [Failed - addresses are not remapped]"
> >      err=3D1
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619093531.40=
38655-1-tmricht@linux.ibm.com?part=3D1
>
