Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F0425CCE
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121062; cv=pass; b=KSJM86gmQ+loUCoxLE5zGvsRYVZ7pcjzmTy0UqibwjX3mRgDV2oedtVdFiNaRNCBWH2M3XbS9deL3noTnuNJtU4MK6KaN/54xnfNTqyb3HHcd/xvZGuq66woE5siHKGppsG066McB9pxpBCzGcQLmjZADcZp9lTcjHH0O/HTMSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121062; c=relaxed/simple;
	bh=YI9XRTOcHXrYyXKBFYt4UpZuvnrOLvj6c5YbD9UM+Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guL9M5il18quP+C+c2UVUtEqW1NN6xVZmKIvhKo/dj9gHwsdfigEZEt4PBhOKYAyT6FQwFJqHjQ902d0ucH+J3oWftleAyqtBjHetBj6XcdrJaFkeh6f5/NT9qKYYGLqah+eo1G4LedhWUE03F0x93EGhYclS+moFbhXOf9vMoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp7k9iE/; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7k9iE/"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899c3441177so18541366d6.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 07:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772121055; cv=none;
        d=google.com; s=arc-20240605;
        b=UwxMcMrsu711ta6bFPZht7UPdzNt0+DK5f7Am94Cn2arMB2bD9lWkjSOi+TFJZDsau
         gmaojzAaIBYKWMAbB671tqBbpNsuPylx4eWSMJzzapJm3faALOA6pMdzkpa4ulreENkO
         lWVdfHvfud5osPRjfk2KLoZko2DGLrJoQATI9PY6DlGryF0HhFwlxTkrOlx20toqmRQz
         dtzrBF2RD3CC9s8y527LukhfQEMqVMLDmxnmuA76RVp9u0tO0z3YahollItXhG3INUBa
         mYypNAp6vPbacyLOFjA4eVtJYB1cJzSSEs2YhJjrd1A0J7NxdhA1bVyZQqpjNqvkKyiI
         2rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5tebxWQEGx1CutgVL/P1k51Wrsw6K3OwI10o+FRJN4=;
        fh=GVtMaqXfzG4dGnRGRLkFN9oqXNmJhQ1MKMwhlV2+hmQ=;
        b=CAalxeIkF6aDGrdv5w0qrwfwRFPJy5Ja5xqdJD1gMvNq2sjuswGyBxh5aCG3CRRMQ4
         rafZ5MsGhcuKWJQsy2BXBz19HpYsts+BuNfH9blo8dpNnutG9DeqTa39dV6zhhToRaG8
         gpNdf4XjfG2VQQ+obB38ldSybh4w8lw7b9tApg1Z/YRmeqRZ+9VUlsj+45xTgbxIGNyH
         h32NGjHXEzas61oVYrAB80Keo0x2wjpGPIeBZKJyXqvR2cJiNnYE+Asm13P3EuKrcoS9
         YPRXR7OVfbDR+kRb46pcs/7enw3BqJHnSRvmtjR9WO+6cUuDsh7rwVON7CUW82lUmFtc
         /DVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772121055; x=1772725855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5tebxWQEGx1CutgVL/P1k51Wrsw6K3OwI10o+FRJN4=;
        b=kp7k9iE/8j7gXNn4LzM6qhY8UwoaSCnv/OummCLS9HSEO+JvQlAQUISU5YSl9M5LzC
         bQ0qaerZY84/GIhzD4YSI8OKtQ7UlfFWJ4IBLkISGR+ovlKtuPJMNTZwrF7d8Pu2Q11J
         d5tA1HsZ7VT73LhNFMFKDkYP+76MAYcxt0InJa7OO9dgTlcOurG213zSaEhit7Jpk/5/
         9K4v+xbWFxF8WEe70/zCeoT7emaSPWSIcK1LOIYf9JPI4W2zY50nuD1ZYuhIYKzxJsl8
         z0QODpWQv92njvJIoqIbyUOklQUQULenO0xBC7XLWydzyHGOP0H6DWUALWq4ZVOnfeXP
         xGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772121055; x=1772725855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i5tebxWQEGx1CutgVL/P1k51Wrsw6K3OwI10o+FRJN4=;
        b=O2Cxpi92A6v4Qupdt9nD5/Y2U8IWsMa/7h/8unnUWWy7HJFBkosCPUJ8Nsr4Uc1GLh
         rkSM5UUzTi5zW3xt4ApdqiZG3f+TdxvP7voDp2c2VIPL6Vv+jzbFJymnfCM/kSATx2Zi
         kH9/ZMMt7tWQSkKWClfcnXu0f3yQ1qydgkMdk+/M/dqOFr1Gtyh/3hQIXXp0w38Eg8PY
         YlhdLKZv1XWrrrKK2UNKKGq8gjvEronpYzPXj0WrN1LSZsb/+bALlloFtfqwcfHYFKaO
         g8hoHxPrB2do1A1fk6XWtb6MsdwFHKt0msIzzit+HNevBT7aJggE9u2xO5t6Uf0c20lT
         UkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDRZUAzwWALKTcu6+gDZKMux5dfPYbMSWhA5LeazwbW2kfYuI1mCESpJdRwkhhhqiM3NvAa29Z3dOfPAFwLkEv@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzYARYJEQwhXllkkR1G4ybyzJpkj7T0VE7uqOqLDVNteLAhhZ
	r7M6W8rZbyDBpfmBI+K/Tlz8kvF9pNNMjGdKqWgNElZv99/2YL0zP+J1Jm84UGf3vHeyqaLnF3g
	WmLOVFPkpWduJ3e0Zw+ScFR/1M8qmdjE=
X-Gm-Gg: ATEYQzwxp8puGMl+5/uB781zhKZXA+AvYdpijOGWezGxzkte5H+VyJR7xw8lmM4CQcf
	sdn6hntEV5vbVx5dJIW8KckwI2fBTzmSk7FGi761f16jXd7C/+vZBKJKVqxwraHzUWOtlSi+8zZ
	AV97fkJjdCMA7tC79JM6bM1JAcO6CVevn829bBeS4cfaNz+PtOfxG8JpcQe6YtLkwa3PcII5Bad
	dc9wirLhF4gN5drBBk1WGvNEzr0S3/ISsGYstpbf4m9p0HQ2tyOZCvvkPImRwaCp6yCxe3L9gYZ
	tUr5uA==
X-Received: by 2002:ac8:5fd4:0:b0:501:4b96:466d with SMTP id
 d75a77b69052e-50741f96efamr56262831cf.50.1772121054660; Thu, 26 Feb 2026
 07:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226122208.162765-1-wangguangju@hygon.cn>
In-Reply-To: <20260226122208.162765-1-wangguangju@hygon.cn>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 26 Feb 2026 07:50:43 -0800
X-Gm-Features: AaiRm51Zd8coe8DLTHssQkILhCZcpUO541XgqAF-YVO36StaG3XEPjFO0Xl3QdA
Message-ID: <CAH0uvoiTgRvYtm4H36JCkj6EDem1MJKuWFFWs_PEuB=2BtUkzA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: wangguangju@hygon.cn
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi wangguangju,

On Thu, Feb 26, 2026 at 4:23=E2=80=AFAM <wangguangju@hygon.cn> wrote:
>
> From: wangguangju <wangguangju@hygon.cn>
>
> The alloc_syscall_stats() function always returns an error pointer
> (ERR_PTR) on failure.
>
> So replace NULL check with IS_ERR() check after calling
> delete_syscall_stats() function.

Thanks, syscall_stats is never NULL after alloc_syscall_stats(), and
it seems like perf now frees the hashmap using the error pointer,
pretty dangerous.

>
> Signed-off-by: wangguangju <wangguangju@hygon.cn>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 311d9da9896a..295b272c6c29 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1573,7 +1573,7 @@ static void delete_syscall_stats(struct hashmap *sy=
scall_stats)
>         struct hashmap_entry *pos;
>         size_t bkt;
>
> -       if (syscall_stats =3D=3D NULL)
> +       if (IS_ERR(syscall_stats))
>                 return;
>
>         hashmap__for_each_entry(syscall_stats, pos, bkt)
> --
> 2.43.0
>
>
>
