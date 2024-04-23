Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF691369BE
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908894; cv=none; b=O5R0hvgv0IGfkeHHnb+WwmeinlIGEqK9Y99RL2QZuG0Wn20wLfRNyYLVMkxB4nw4HlRauPO8LVLJ9dmuGivoiD4MN1vhXbaECUTFU6vq8ZJAOe1CIytRnTw/+r7ebdrZMIbmtPUbY3ZolFH82q8fQqBx+DD1qMxs7KPeOg3JHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908894; c=relaxed/simple;
	bh=ztw70WIqVQBaNSH45npjc3+FwzycdJ4D/SvQ14SFB8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWzi+eKFv4ylX3ZH1ywnLCYTANH38u1nRKqVaHRP/dp8Bk91LQalae/RryK4NCtxVG7lBnD5ln/5ipflzTYJVUiP9D6mEQMAhL5I55OMez6HEvhQjqmuRsVF5kFaH5/96Kxm+cXItKiuLL9tfB6qeo4K3xdumdWdYGXVoY7pkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rfh3yqj7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rfh3yqj7"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436ed871225so43611cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713908892; x=1714513692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOksILe6nmVL7yfoj3z4gNTzqZws1cudHPepaiKTCFw=;
        b=Rfh3yqj7EZCXEZF3vw1zrM9hY36tMpEXRQauZA93WUA2LvkOeuwKYSE7+K92SR3Alx
         O+7HyGgU72a/sES+AVgRtrriJDpirGB9CSeyvooY1AjeA9tpJBxvJCRSBMtcoMB215xT
         hVkIf7nD4R/FhDpQYmA86rU2nHT7GuhzyJZcOrw4Li3yZ+d9O2+Loy5yxheMRsAu08QH
         pCbbVvoG0gf9+6L3mfYVZNi2Up1KUhlpjFLBhoU2YSJh9H7lkH0UNFoxyzJRQGEBcUn7
         X5nksqFtRBFfWLSfcFPkV9OXpfPW7ekU3uY1RcVlZc/oY545hZdmMYzFkfwZaBDTKd9E
         z3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713908892; x=1714513692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOksILe6nmVL7yfoj3z4gNTzqZws1cudHPepaiKTCFw=;
        b=UVAX9E1Tc/jw+V2+NjsnyQyUWfIGgbmaY2TPsQN7eZDzq/7syo7pNEB+Z+FeXdqAmA
         o+erqttr95GrCRPu4NgmBLsUyT63mwNIu/+oQgyJikCFvqYBVG+QbVqu5LNXTllYIs6Y
         Rr7C2Zw35lnXMlY9FIX+0M29iyqKBh689rh2HzrTVjuibhA5KA5emwhn9kQCcGYVDKW+
         riT84fZuVIW8a3UPRPt5Wm7lXzFJeqVgQFqlHyDnEzlGpiQ77PN05DOF5Ir7ya2eJeY5
         wHj0Sb3hojO+gs8uOcfa8fu+TUTU6zw/nsah1ovEkprxYFCBSGtCP2rIRCjoqU9MNPx8
         JahQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6qlq+bO9m/TOXth8XjwPlzCSUiFinpcixYdD7X1Bmpz/jHiw+b3m24Mdh/sNo7jLq14mRAJ7VHBPyVwjNRtSAe1VVeXuBHZm4R5WNOyn5A==
X-Gm-Message-State: AOJu0YxBL6MMwfN63mbxlFWJExNw0a2OxWKcwijjL5uf6WxKZFE6bP2+
	BEkJzAB8dW0K7zMPRuh1kGBgB8OBDuEVSdWucC18W2ZlwRYGKy8cqo46IrTgk3ZENZVddWiDo8J
	pe2k7Z7snkdShbPxPDIvLFXWr2gzUmJIjju4C51ZiRULBDe1X6UM1
X-Google-Smtp-Source: AGHT+IHmfmt+n8ZHr2UBZvi0KLd1MiLpZSd36KI5Slq28e1mUs9ISGikELJmw2vgTIXu80YXGqN4ALSywcsgHOYDleI=
X-Received: by 2002:ac8:5482:0:b0:437:c4ae:f3b4 with SMTP id
 h2-20020ac85482000000b00437c4aef3b4mr82800qtq.26.1713908891776; Tue, 23 Apr
 2024 14:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZigRDKUGkcDqD-yW@x1>
In-Reply-To: <ZigRDKUGkcDqD-yW@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 14:48:00 -0700
Message-ID: <CAP-5=fV0sX2V5+yjTymzDFXakxZxFxKvokCOqobOFgZHn6eVsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests shell kprobes: Add missing description as
 used by 'perf test' output
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, Michael Petlan <mpetlan@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Before:
>
>   root@x1:~# perf test 76
>    76: SPDX-License-Identifier: GPL-2.0                                : =
Ok
>   root@x1:~#
>
> After:
>
>   root@x1:~# perf test 76
>    76: Add 'perf probe's, list and remove them.                        : =
Ok
>   root@x1:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/to=
ols/perf/tests/shell/base_probe/test_adding_kernel.sh
> index a5d707efad85cb40..63bb8974b38e0b0d 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -1,4 +1,5 @@
>  #!/bin/bash
> +# Add 'perf probe's, list and remove them
>  # SPDX-License-Identifier: GPL-2.0
>
>  #
> --
> 2.44.0
>
