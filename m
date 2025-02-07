Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17A2417DB;
	Fri,  7 Feb 2025 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890283; cv=none; b=t/SNgRstALn0nO58GC8DVl6ADWSMs92XRkIDFS8kuS1TQwAJ+2ez1w4AvHmaRe+mFJLql8tUpM8pM3caOqJpBkv6x+f9iKBmeJfcALV5DTcPT+b+72IIul5+z/CHfnW+wBR3aHELjOeKbLh1/Z03fWaLZ3m3Gm5iqwlNBh847do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890283; c=relaxed/simple;
	bh=ZL+ndmNfqd3tamYa3VWakgMQzhn04vpvwNH6uRi65lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwdXAVWwjYg4rkGSfSWyMTx8eZvqImZ8N+2Zu1CqKAeY6XznCpC8IiJeWpb8qxeYln+ruFN5u3EjQpHvCA/gLZ+qZre/oZ11JdwNcCp7TaYGHvf3ZonOU3KDCVH1kxMcv8z23og4pyPIMCbibAXIzncJTzZXShsUZXk0/nQWTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX5vGF3G; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX5vGF3G"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1215686276.2;
        Thu, 06 Feb 2025 17:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738890279; x=1739495079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBeAB9EAPsdPt9h4RsZ9JexiVqKep4iAtSHxkdAthOk=;
        b=DX5vGF3GL+Ol+/EjTKhHvzptqmfA23Cb+wWdI9NnjqoiO2veRTngMUcN7LobvMtiOP
         QDiIf1s4UA5GhZjT4XrsIcc2173jTgFmj8lQDQJhwGW4ejXP0slwkgasriWa2mN8/0Ls
         DngvEoYy2H2JDZnY5bMWJmPRjgO7v12L7Nc9evswNGrzVQSgxZ0QbC8Z+pU2HfLd5Ksc
         TORGfHrfMuhIciih2+wKmyAo/iOITm7ITZUIiBjN0o23XSpCON57yzrKz+FlQ3YRCiDl
         rR3yHSCdDtqttN4nxlkY5QllGzK6For0dTWyassk4LbC3aayp+he/O+PINCMzk+tIcWP
         0+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738890279; x=1739495079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBeAB9EAPsdPt9h4RsZ9JexiVqKep4iAtSHxkdAthOk=;
        b=fcc9okwEJTu3HaAEEIDCMZfnmI0szEn6MDOOET2asTYornpbaXiPUx5q7VDEX/yTzr
         kctO0UWx+A1hjCn8ieAHb5Zdm0vofd6deV35n9miZRyqEr3zMGAQHDo3DqaYg5pNFWdH
         EKCCH6B1r0XkYN6U72Po5lR3dyp1btNz6B5qlzFy5kB96ZH8TTXC88N5yIoyIYDoja3Y
         ccIr+vv2KL1hjvZ5w0g+Z4ai7D3fe0piZRS1wmpq3MiJknlrOrvAeJv6nr7WnA7u+uc5
         2zKof1oBCTH9JeOSfqPRHIOGrQq7Lgo/Lg5RLjMh5d3XaDBdDVaoqK2L5mNM6iR7AMLv
         n70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEjBQ+E35jp64E0jCc/vv/EzJSRh2PTcISfId5pmH2fJwxESfoxxbGTLj33IZ/8bVF7STPSJuxug1ddAI=@vger.kernel.org, AJvYcCWtFNKhcTQajioLOoqT+ocibto4duPsFLrqnD5Ta4GhtjoEFT2drm9AMBl1RlBf/yYsPVbbVEHzELGZG7ppTY0ZJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK0Zy9DKH9rLHecycog8ZPw9vp/ZzjkGh5xgmXojnp82n9M5A
	KwNyMyUbqe9yJGgYkAnsfupP59XMwRXkod09MQTpJ4Uvpje3z5Smkmm+ndkfXa7axes+DhAcxIv
	0lG9J8UGemRA0r87FhPtck7uLKWXH4rCBcnw=
X-Gm-Gg: ASbGncsf7Aq3hfG8SPvbElw5FnoU4iVtv9IfTFSjxVIuoco/pggZEfqoKHR4uhdQKZp
	7/iKjx/xQ2BwNfMG8++A/HidKj6pIxs2GdsQq3nhocrH1P3AdHEa6HgfxBWaKNrCNEc4XVGECSA
	==
X-Google-Smtp-Source: AGHT+IH3PuVwAoFUjAULcqQwIb0hR5Y6wMOWun5P+e33kfKR85xoqXMtJOVgBAjytAxqIK3Qwa4LXHfXrr1ZVH51WVs=
X-Received: by 2002:a05:690c:c96:b0:6f7:5868:86ea with SMTP id
 00721157ae682-6f9b27e746bmr13652667b3.8.1738890279357; Thu, 06 Feb 2025
 17:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
In-Reply-To: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 6 Feb 2025 17:04:28 -0800
X-Gm-Features: AWEUYZlfkHpBVzqXbre-MsSMpmUHF-Og9KBIsqtpvym-LfMnbMzQLHpCrvsUUYE
Message-ID: <CAH0uvoj-aS44f78iQiVqDZiR1mN5SHcXgR17_Lnu_b5CC-ZsPQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Improve startup time by reducing unnecessary stat() calls
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Feb 6, 2025 at 3:36=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> When testing perf trace on NixOS, I noticed significant startup delays:
> - `ls`: ~2ms
> - `strace ls`: ~10ms
> - `perf trace ls`: ~550ms

Thank you so much for this insight.

>
> Profiling showed that 51% of the time is spent reading files,
> 26% in loading BPF programs, and 11% in `newfstatat`.

That's a valuable piece of info, thank you.

>
> This patch optimizes module path exploration by avoiding `stat()` calls
> unless necessary. For filesystems that do not implement `d_type`
> (DT_UNKNOWN), it falls back to the old behavior.
> See `readdir(3)` for details.
>
> This reduces `perf trace ls` time to ~500ms.

Before:

perf $ time sudo ./perf trace -a --max-events=3D1 -S 2 >&1 1>/dev/null
         ? (         ): :2278675/2278675  ... [continued]: read())
                                        =3D 1
real    0m0.833s

So 833ms.

After:

perf $ time sudo ./perf trace -a --max-events=3D1 -S 2 >&1 1>/dev/null
         ? (         ): :2274650/2274650  ... [2: No such file or directory
<SNIP>
real    0m0.805s
user    0m0.004s
sys     0m0.011s

805ms.

And the results are consistent. Apparently works for me, thank you :)

>
> A more thorough startup optimization based on command parameters would
> be ideal, but that is a larger effort.
>
> Signed-off-by: Krzysztof =C5=81opatowski <krzysztof.m.lopatowski@gmail.co=
m>
> ---
>  tools/perf/util/machine.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2d51badfbf2e..76b857fd752b 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1354,7 +1354,7 @@ static int maps__set_module_path(struct maps *maps,=
 const char *path, struct kmo
>
>  static int maps__set_modules_path_dir(struct maps *maps, const char *dir=
_name, int depth)
>  {
> -       struct dirent *dent;
> +       const struct dirent *dent;

Is it necessary to constify dent?

>         DIR *dir =3D opendir(dir_name);
>         int ret =3D 0;
>
> @@ -1365,14 +1365,20 @@ static int maps__set_modules_path_dir(struct maps=
 *maps, const char *dir_name, i
>
>         while ((dent =3D readdir(dir)) !=3D NULL) {
>                 char path[PATH_MAX];
> -               struct stat st;
> +               unsigned char d_type =3D dent->d_type;
>
> -               /*sshfs might return bad dent->d_type, so we have to stat=
*/
>                 path__join(path, sizeof(path), dir_name, dent->d_name);
> -               if (stat(path, &st))
> -                       continue;
>
> -               if (S_ISDIR(st.st_mode)) {
> +               if (d_type =3D=3D DT_UNKNOWN) {
> +                       struct stat st;
> +
> +                       if (stat(path, &st))
> +                               continue;
> +                       if (S_ISDIR(st.st_mode))
> +                               d_type =3D DT_DIR;
> +               }
> +
> +               if (d_type =3D=3D DT_DIR) {
>                         if (!strcmp(dent->d_name, ".") ||
>                             !strcmp(dent->d_name, ".."))
>                                 continue;
> --
> 2.47.2
>
>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
