Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B323812DA
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728356; cv=pass; b=UVW6zgwxgwc8eGX28gF5Pg1nppxQSRcBaKOL6MGjSvdDxUVM348Gfqa8JjQOaJ2H6o3ZliUy+cuJjiQqQA+hnJ5+3ypvm/MNtEXmtEQdJqrrLk/btH8J8zbF66alQcVD4IHdYiaKf6q9zwRHAf64a+qB8BvOumtCBtMNgZ58Bss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728356; c=relaxed/simple;
	bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC8LAYEk7PKW88fRl7csgM0N3q1/CjHxqSrrnH8ksc1VoV2MyUaVFjtm2/kFRkh7Qwmzc/w0S5au7FhCo6+9rk1cZKMYL/Q00xOHoDgHXweu9wzWGScy3rG/OCs6egfhqnW7nAdBZ+P4gypXMIVz3fjfnvPXjrltH5KGLg4RZTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1PZCMAo; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1PZCMAo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2667110a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 13:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728354; cv=none;
        d=google.com; s=arc-20260327;
        b=dKUFl3nhDrapIc0vJJYrT5YLm2191SJJy40DJ0wErA2TNOydDlkUpsW4SkaVTzeC2G
         o9ygWrDFCI8RNXJGNqlPzihzeFzcNdmBUVIUIGv+4ai8CtPEnPJvY/5N8w0JpEqsYYc3
         Xhz3603GaeXS8g97rj+X4yhcVWKN//0srF7TGqxGoy2nkPDXmNsrqdXQIA1rOK5F7zPV
         W0h63nrgYZmhhhhuwCN1+pQkl/IPLmYGlxEsCWm0AcGjoBRKKeqZaIG4O1SiHPr+O5y2
         Vh2rMxA2GhmaI2b/nXheyq71PWmj33QtvGbtfBKNz9OYJQbRRXb08OCOMSc3rhAEHO/o
         EEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        fh=MHcIYoJr+fBpWFnwPDSLH01BVEhK+cDuPVWd4Hw5+/U=;
        b=JSdR2rD2t3krnPWKbsQ7s+nHfZMIvenmTOvnl7QiXWD3vrsCHCGOT4LiVYr2pCgrln
         3gzAJy3+uPDc0pY4KOKk8jn5M0+twt2SWBWOhSfTvWs0KVcixKEa0Q0HQVEcQ5xw7Jg5
         qwn9hCHw9Ck1RkhiALFYhTZlFBsC+iNQGcagGVtq9rJu/dOq9vmAk3XBOGcXj59Nuwk9
         7QztFyRsjGxfktKczpf3rIGWwi8T71nOEETo9RJ0kiG4r4F924z0OMpn7HeJ3seE/JCE
         adRDb9dkr/9aSnAfpVfZRdlLgPhdLAKWAjs5PirjtzOetzMz+zpunCh8Da4LylLyt++5
         7NRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728354; x=1789333154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        b=N1PZCMAoq6Rb9QffgHeGjEtFdwwKouQKwPNj1i2h0i0wJn/Z4n1/nJe+grImNNpbOc
         2Snkh83IjCBfbiDYjmJgt3fBlfHyR5ImSV8OxctE1W8N22uVlDb5VFDIiRe+cNKj/zLe
         AwFXfA8a0j2zSXnaFQz+BySrQeLtR2FnRMUQrpnCWWeyhnstEFa9ayge9uxElZy/zP38
         Z5QbgbJ/jW0E0B+s2rpmd6fY8EWowGyNdre3qmAxnQBeqICi1t7YbtMfRDEBfgqYMYdf
         Bme1NINbbQf/iM7leVTZsJNtpL1024amABE2zRChXG5mIqk2kNUGAbj20Yj5qSwZmf7Q
         TXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728354; x=1789333154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        b=nogsnv5WePddj+gTdDRTZ/pypXlgoJdBBA2paMjs36pkQUtyx1ub8vuNS/WJUi2dJS
         oQNSMvGCMlTcJSX9oaslnuycZsiRop9OiiggeltDvqD5o7oI/EGYQjyRhLaxqbpSG+/I
         yjuoBOEGfnzxRFbj6jgtwuKFo5Bar6QbtNd3/DfufOUEfQufLbfwdGRhtEe+91obit+I
         P2oBIwkfUy+8xf2H+AEN0VIDeGQCI0brWL3O/FH7yAfA6docJdbCMZyoxhO8kEXYn3O5
         O42O9AKSahe3RI3TKdUzKncfyY3APcDxAp9CyAXUucgU6NnB0Fu+5Nxc1kt56bymJHL3
         QMvw==
X-Forwarded-Encrypted: i=1; AKwUvBw13dq1xanyywkh6p3SbpAByJC0YlIhqemg8kXNTpCncNiu3avZ3RI7aa6PouanRTrid6ZP1UA6uQr2KxZrAujf@vger.kernel.org
X-Gm-Message-State: AFuF++nxy+SaQmnmlM3VhZ6pWyamZ+QW2OQp7CCnaHhx9hTOwwao8PKi
	IAldDqZkIFuLsw68xP+4gPpj9h4w0pu8uERhwmMTKBZNhArl8We8MnO/uBrrzD3XN+wqLWhTnFc
	Gzbn8UxRad94QTkdS9n6Nq5fxrj6gCQg=
X-Gm-Gg: AYBFou2IFb8SFhDZKajVhvQvDRfeirh5/WxB3JmcoNadGrqEveU7FuHWPtC1zrHDVYb
	dwoDCvX9Wl4d0J/ND1iPaoSLmHpH9vfLZmCeOvgsqEVSufJPNbzS+2bIxWwRghbghi9k9BGEzKf
	l1hTZCIHQ2IWqvF5MEDI5GsSJEtm+0s91ycrwl7/ycBgXM0eoZEVLboCi+ejT42j6AoYGrDurdA
	zOFPeSAx1aWrMTq0RZY3VUiRiOdo4LCiuozZEZC56+dG3NKsm7tjWmLUiUoo9gveG3jTWmzxWmw
	kgvYNm1XKv3embbPW2auRr8VgXhPz05KklQIRxqaECwt2efRCRZAOsRTcrrZtIyEAUdCOlt1KvX
	DPj3O/zcVDQqwQwZUHAOy/zC+TcqU
X-Received: by 2002:a05:6a20:729e:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3da39bb5957mr28017799637.4.1788728354236; Sun, 06 Sep 2026
 13:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 13:59:02 -0700
X-Gm-Features: AcwNN1W60lfgmZ5yuSBplCeQGrhxaU8sIs3bdr3CFsw0EYVrdti6riCJvMr2erE
Message-ID: <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> GTK2 is long dead upstream and increasingly hard to keep building on
> current distros. This series ports perf's GTK-based report browser to
> GTK4 and fixes it up so it's actually loadable at runtime after the
> port.
>
> Patch 1 does the mechanical port (build system, widget API changes),
> including the leftover-GTK2-call and signal-handling fixes that were a
> separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> port that prevented the browser from loading. Patch 3 fixes two stack
> buffer overflows in the hierarchy view that predate the port.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v7:

Matt, please stop the spam.
Wait for humans to reply before respinning.
7 revisions in one day is way too much.
