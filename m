Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE34388873
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182261; cv=pass; b=OvmoKN07mh3/o9EnROMbqoWJ+1OOOUq3144JBeOl4ukG/3CUpLsApTWGLsu4y/e3QRveUn2viDODliuVWDI/PIlaMXqxtdE8YJGvADgpeiCMYS9/oJIRUWSMNtTf/03MKxhQhC0u63y49FCnsNoVTVAOeW7BA5MlAEqMbtkm624=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182261; c=relaxed/simple;
	bh=YKV26By4+GumxrdgSneMkN8VbG9jPFscys0G5tcpC+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzkpCzXkG6h+kJ1nJBX8YSyQPyYkW6iRYHq+wa+EVHcxLZMV4G8M+tKQyztiP30FwS+Og5Nac+EVHJhkSHke4R64SAUqzCgbgKfBmQ2Wj0y9q8lA47wxYdWc5x21z6tSuW4jfFivB2urgcTJqy2fneXlGgGmcWIKZinEAbx18jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZY9h7C/; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZY9h7C/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cacef7d299so51685ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 23:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784182258; cv=none;
        d=google.com; s=arc-20260327;
        b=dAhropYelwVBSz01Jud6QTrvUbhjesJWuZp45E2CPVZGyZLd4ycDbn55c7Hp+kwch0
         I29GFLaIa40NclblhW+rV6o1YQ40fl/ZuaxIv2ohR7F2rWEHbvWl4jdh3yYPxkEpcqmX
         HzS/Wdn0/jivfe189Fhq8SjLlu6WhTSDGXPs7wWTRFinmDZMwOvSfOyYzUo2G5+/kd1U
         c4chogxrdNmsd/LjQMyz1L7FmU/7CMBKwiIKTZM5IWhFmtGQ3mHkHafZ6JnLdVIka6Se
         tY8o9yQ8H7e/zwnT2V84JnakhpeX0RfVB5vF2rfqbznevLOyscMN5Jqat4eK9TKwE2bp
         blkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i2qRYKTpiPRd2XV9f+Toku+inGxjOxT6jXxo3Qi38v8=;
        fh=OIZIrLKuMf7AN/k1BApDl+ike46pEvv3wWmsqUag3YQ=;
        b=PrV4IOoPq1BXUIAtK6AOPgB+6hSZ4yU9paHBJjAzBuXrFFl7yoxAjS/LP9zCSBksle
         jgbexIE7S5EL7EjLDRc6HnrhYJgG+LF1gs/6Jc92yb+ef/x2pb0SIFaI3ejdZ8Y6j4oG
         FRUBRounHe0Dlxg897vlBIhlR6oek1DbqMxOt9T7J+Vpy1z1+Nrs+IMgMc2bl785yAHy
         9gdU09lCLZ/9Dnvza1SID8jmBjoPYmW//7xQzSaxGOgYRiIcsbDqewPK3iz87y6xM+KB
         gfrznodeNcyzHTLzafASn0q1ESTclpPdrD8hvw7EpCxZtVE5YCQW8E0MkQbUqd9KyxHd
         OZGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784182258; x=1784787058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2qRYKTpiPRd2XV9f+Toku+inGxjOxT6jXxo3Qi38v8=;
        b=DZY9h7C//KpywYM2wEnnPj/53BtQlladWecPpVyLGAnQPdrfwJc8P4y4NZ7TRsQuZW
         PPOGbRLCG0bRCoB+LeqbJZl8s1hvvWDTJ1IHLB0OspuXlTnGWPmOOS+82bre9i6sqK7e
         oEEnTaJoRrZFaD1kPD8ByV1K3DrlC9gCAlAEunBM5Lz5fMipbIdxHePgtZiMFck+hos4
         NbsKIcCPMMCeALJEZTjGWUOwK1eQ5X3JTz8iMEMoIJkXTV2B8LiC+Y1AcAKPTnnib2Zr
         OrBG0/twDCwOY8kerhp4C1SdHaMe/wdrMszSX9xo2zkOQvupHpawdyHFP/I7zaUUtfdX
         P5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784182258; x=1784787058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2qRYKTpiPRd2XV9f+Toku+inGxjOxT6jXxo3Qi38v8=;
        b=hH56ViT0nS7MjsF/kfghjUsg+Q3rjUshIUgzL4XO4rJ6iW67HuuToQqv6znQpQxD4y
         zqratluSqQ0RPol2oFwlNjdGs+3b2Q84vUi0lxDflqLAXj3B5IQAw/AmA+XCtF1kfOgQ
         v2AG52e0ZUGAZG4Hy+AXYau7DFjNrwURxJvRKMxT1IYonmox3h20bOO1MW6xnrlxdbtu
         Un6458ybVWgc0Jj0y5fMWVrW6ej6OAbw6UmF9cx0loCkx6oNPXfDJLrNCUzVqX9Nj9WT
         zIbE3FSqvekegrZOSjyS0Mu8TueGz6W96CepGdhLeibhlvIKjV48Z2qKhdRPjZJrP5pv
         KYwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5kcy9WqRIQOwwxZ8DBqGsepqbKOPyZ2EYXzXZTSjeA+Yi3B478/NdOnLsCE/IhlQCY63jT6P+wvZRZCaDwaN2@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZfMQbw4X8k8AVAOBf7iXY/YzlTTokD/4ZRk0QQBHajCcq0pr
	ilkhe8JtiZ2X2KklqyjqO+7ve2vYzzZIfGNtnnLqx8mQBW+pD5q8qzMBBjV6L7Z63Y7TxoR1+Or
	qPnvoCFjIGVnjma4QV/ygwYFCeQuhBNhfHrDPj2hC
X-Gm-Gg: AfdE7ck4FS3yqbNGns/BASagTwGvl4qElO1peHlUbrPjRj3yf1Fzz6CdZiEFh+izYS0
	L4blfQVRypzrtfzQXEEeEQ60dBy20Eyih3MITZs3iVPbmZEC+sVy4VsYkK9DlWoGYZcwSQmZBIJ
	4tz1r5+CsjkHH6XQ+gaFC4ROzR2lmKXgH4mk1myDRn+S10QFb/4/4oKvYJu2TYB6soB1B0lYXi7
	Sk9NmwnLZw/DVkxYVzEo7qev6dC8U9dwCekPx3E7eOE2cYC+pBXPTrK1a8ViKhoQGcqVfZxpA==
X-Received: by 2002:a17:902:da89:b0:2cc:80b9:3a1 with SMTP id
 d9443c01a7336-2cf1dab007bmr1449415ad.13.1784182257647; Wed, 15 Jul 2026
 23:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711003235.1963043-1-namhyung@kernel.org>
In-Reply-To: <20260711003235.1963043-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 23:10:46 -0700
X-Gm-Features: AUfX_mzdBtIjzaaFAvbO8SHAeaB7c_aTJz295WGVx2PZGbhQqU0uFCC7F2iycuY
Message-ID: <CAP-5=fUUxtNWwy-3cPaEexG2h4xF-N+VdqoutoZjUU14ei+aAg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/lib/api: Fix potential double-free from fdarray__grow()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Sashiko Review <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 5:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> If the realloc for fda->entries succeeds but the realloc for fda->priv
> fails, the error path frees the newly allocated entries.
>
> However, fda->entries is neither updated to point to the new entries bloc=
k
> nor cleared to NULL. If realloc moved the allocation to a new block, the
> old fda->entries pointer is now freed memory.
>
> When fdarray__exit() is later called to clean up, it executes
> free(fda->entries), which would trigger a double-free on that old pointer=
.
>
> Reported-by: Sashiko Review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/20260710200150.11FE71F00=
A3A@smtp.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2 changes)
>  * update the patch subject
>
>  tools/lib/api/fd/array.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index ffe8272af59b2da0..23b476a35de477fe 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -31,7 +31,8 @@ int fdarray__grow(struct fdarray *fda, int nr)
>
>         priv =3D realloc(fda->priv, psize);
>         if (priv =3D=3D NULL) {
> -               free(entries);
> +               /* this will be freed by fdarray__exit() */
> +               fda->entries =3D entries;
>                 return -ENOMEM;
>         }
>
> @@ -50,7 +51,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autog=
row)
>
>         if (fda !=3D NULL) {
>                 if (fdarray__grow(fda, nr_alloc)) {
> -                       free(fda);
> +                       fdarray__delete(fda);
>                         fda =3D NULL;
>                 } else {
>                         fda->nr_autogrow =3D nr_autogrow;
> --
> 2.55.0.795.g602f6c329a-goog
>
