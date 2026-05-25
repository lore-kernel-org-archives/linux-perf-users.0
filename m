Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8935DA5D
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752166; cv=pass; b=gjZwyUqUpm5aChtUPbnu4O87dcGLNUuB3l6ZGNv2+1+Vto1xAz3tYlZzURCWn1LQ6QD941e1lP71fYmlSY70I2SdSJ5NqHjOarfz/vvBFrPE/YpX1SQB2X4HsyOOgPlcJ8zsHL4cSsdjawrP7FwpxW6fi/GeEZHD+VajtoWLgDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752166; c=relaxed/simple;
	bh=HF6e26OxRg+AVjWgwxmVqfY4dslRrWwEozcxZHycbCU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ngtpYMOI6p2Xq1iS49Hwhbp3dSUEah4IfJhUDE4XDejQ6+WzddWoWgQp5k9BAF0eCT7tQtaHFHvItDhmHPoKuaf49e338D3rV0EbKCkcQQJakwRsqu7cahYmDZUWSa8zGC5kg2oksY+/t5btByFX57XflRehFYlZGXDEtIjUyGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DmEtJyot; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmEtJyot"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso175ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779752165; cv=none;
        d=google.com; s=arc-20240605;
        b=JAWe00GKiRKqN/mZHtlsPrkZIRufcQvJLnTTJ8OqgozP0x3ZlcQ27eQjls3SX5AlTt
         HJtzVYn37Ujge+sSAnHCFzKV77CNCXFShBkeEIpP31KmnfEiZemdYQ3FdrILzVrqzBPs
         RgndJMAKhkKwPIv40txZCaVZNrlplmU7Zw0ryP3G2FnbHvcWOe+6PPXXpyhsVhYCWdYu
         rgXrNfo+8NaibisbhJ+HdT6QzBaS4OrvCeHeUHUklQg/nDJCdKdI8OEdiqfhodo3DHlo
         ny0TW/fMDTL8SCKYPcp33iSVyd4cdKjz0clMfOAoKFW4J88RjfF28f+VxR3EkxOk/LHQ
         ehOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HF6e26OxRg+AVjWgwxmVqfY4dslRrWwEozcxZHycbCU=;
        fh=DSVrarOAkMCw6bEAnqR8xcG+DBjoyB2D/F/r4SOBfNc=;
        b=LqpUfw0yTQBTbi/TxiUDprN7ztcEbHiApw/F4qRqp3lmBt/MuYPTwgaW6MGaOzEzS/
         IdMyiYdkcswPtfsgtC6RGetibZIj1tzjqUwwfCbWS1/7cndHxkwk7bsJkt3XFTnBt0pQ
         lY5LxuaJ05ZY+qwcgvthV+l9LHyRckImSo1v7vXbn66alqAu9cmInqztB3a8OVIrbReV
         pcWDYOn7Unc0MUOjKQjkX+VPp/CfAVt0MXfGzEVZk+OGwSZxv/nxi4gBGZ08BJy2cu7R
         +Xm+OCV9Lt0+bLgrHdp5eEqdW7OhXqsSxSm3pMJNc1NepHEdK2nC0Ua1TU9vsp1t4Vtq
         d9Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779752165; x=1780356965; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HF6e26OxRg+AVjWgwxmVqfY4dslRrWwEozcxZHycbCU=;
        b=DmEtJyotJYyJMql8lfbdIL1KdQJD/BoS/tsEAXUtargtZBBxKQHemILIlackByfsjo
         HiOgjSO8Z1EA3XtA+TV8kc/iBKMBygFwnInMOIWpkkdZ0B/IGZeR27ea1yezHS3QYqNF
         g2pejt55c9rZ0G20jVIsWi7NKCfJw9DNaiz6/SP4hr2+6s4OCdOn01VbMzjGfBzIDspk
         VrJi3L+NeDd5aPYqvmjx7iGyxAFghiVbiBoDfUFZLtDNtQrEXzIQcdDVaRxLy9GrWvn6
         g1P8W2iqo1nPu6faplYVPLgemZwsiuMQuxdtuUjnNho22px4Tem3dkXjGymYBsmmo1c5
         xTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752165; x=1780356965;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF6e26OxRg+AVjWgwxmVqfY4dslRrWwEozcxZHycbCU=;
        b=Ieh6dWRO2NqqVW5NC7FK5tPRito2JmlfKUZfa1J2TOFNaVNmSgI1/apw0snXk5HZIe
         neSzV5JpuO8MFqS+jP0uHoxRQkej3Keq6Q0VxEMxPT0lX+zHK26tFBfwDTR3TbQN2aWp
         n63YVwFFqE4xuQAVx69GfWOIEjnGeA5gtVyNVIII2W1hI7OP5d5HviyoWrP+whZIIQh4
         i7KQw7UBqp2ppy2RwsIMk47woG828yK16Iw/JQp1EiUbpiTQOlnER4GhsmKWvCdTAueu
         y2Ixsy3FwTyf/pqW80/qnvPt1qfYlkgUqlcwiTjiqI5A2xrAqYQsxMkL0WHlxBExZk/x
         rs3A==
X-Forwarded-Encrypted: i=1; AFNElJ+isp++4e70kdHhI0N4f9ngTyu4rcASdh7rER6Avz8f4stO8wAQ+ltNjcbNoFAShADqxJI0gitmNLL9zbeLhyxB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3ibshEn+JVOB//Tw3JYSB6gnsuCCHTNVZMfVsvxoYhlN7aQv
	9Ud6ZFgUj2hXr4BhkpfxOJS5S3ymg9L0ttslN//kGCC1fSzcvDixxiUCI+a8V8I6/I8OxFZx0f/
	jB8fTP4hyiB+uR8gSV4yyIljJAd4YSW7LSvMqZ4ho
X-Gm-Gg: Acq92OFNcyFA7cg+GWaLwN0cq2Amm7tBk50ZigCDuneqVXH7enuMKeZwVIqxVd9WuAq
	Tg78W/nRm7YkebFqcySYNMNZkQQ1U3Jzhi06pjGGGTC/JWLqfnnCahhd83cVs+Y50PRfSd2XSgm
	cZrPUWD0k8jod7k2j9rLVjWLxQ+k5r8D/M6QkOkbsYLE2ACw7Ak8H6aoewD3/IPzAArySaSphus
	goSjwRhj18zTyiO1+VtpUr7t1nHho6t800E90gF4k29L3+CZ8zRMrVrrwUh1NtsU88H3ADL12bU
	SKJ0f/RHGi+EhQDvyBM=
X-Received: by 2002:a17:903:228b:b0:2b0:be7d:a25e with SMTP id
 d9443c01a7336-2bebf446cfemr4355985ad.18.1779752164295; Mon, 25 May 2026
 16:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 16:35:51 -0700
X-Gm-Features: AVHnY4KOBEdsnB6dAUxGIozRpLPfsWH5UxImxNCUUzZ0OE7ZgdsmtgBLLYfLXFI
Message-ID: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
Subject: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been working on a script [1] to summarize what's been sent to the
linux-perf-users mailing list (using nntp) and compare it to what's
merged into the perf-tools-next branch (using git). The idea is to
make it slightly easier to track down patches that might have been
missed. The script shows what has been merged and what's pending, what
Sashiko thinks, and whose turn it is to work on the patch (author,
reviewer or maintainer) using some naive tag analysis. The output is
quite large, so rather than adding it below, I will send the last 4
weeks in separate e-mail replies to this message.

Thanks,
Ian

[1] https://github.com/captain5050/ian_tools/blob/main/missing.py
