Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522330;
	b=c0kEDTrH2YwH1TsIXoCHnDn4UviiNQUy+7DkuYqQIOgheIdKdz1hD3cAC+cs626YqpfZ
	 BFa3f4ih+QGyXzp2bAUUDZe6SJWPwHfsJ8U10bI9EDS1AznNRgZewLGxrDNxkPfWkvENV
	 I16+PWYVWHU8V2heFL9KurQi20CgTfqBFtun2bAO1HHPBKxK2uAZbt+D0EjRUHjY1tSk/
	 QpPMd1EnMYNEehAp5VfIvye9TuwRxMu2jYxblFC3epo7TQXUDWEnmDOQlDU0kRO97KMiE
	 BQX1rl7/zCozgEbqz0vvGEIiOlwoZeDdgsnqIma0n2QfqTAGlBDKaC+FfR9mIYz+7OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=foaFfB88socwxfhENQukeiUi552VaoZHM30SQaS2gNQ=;
	b=DV1xm0m/qJeXXivSXRNaLf+gokhzeqreY33w8wU0sXI2MljmifLctK+kZqqiiVLp/3Zk
	 X4ta6PMoJkHAX1pUGamjcjdfuGBTV8Dv0MiAPp3gFUD6lWgU6tjaeL0ZOEOwvPATE7wTZ
	 8aTG+Pg/FC4dw+7c/R71Lj+ZYo7w86oRxC2rMPET0gZpKEBtzCamUGwqLgTD+xu1jMOf8
	 UQX8xrroqUDsF7HMa5YyLGE4vtDej6KCYgN76Iq/CNOaQ4qQfQCJa3NYieJLlK2Pss6Hq
	 hsONSvD7KBFGEUxqyLU7zKUjbvxbR8WevJgJUkMewbw1gpgwi4DPT1xf1H8y3c4UstA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZp+Db+3;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E5606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uZp+Db+3
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1438d9363fbso216950c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794522329; x=1795127129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foaFfB88socwxfhENQukeiUi552VaoZHM30SQaS2gNQ=;
        b=uZp+Db+3VC61cPzhJevYcj/nYnYq2V7XUfQOTI0LwmsVsGLqBPDYmYJZ7yvmROKePH
         CCQALlbQ0INihRfoYfvgY6FgfOmjywq2g4EyyQiHn0QfB7gB2Xiz9mAsFN8rac2VXszJ
         50oONRfrCZqt8ptVK7F0THgyrd+InnbRsliTTubsMccQT4BV24WsoFCzeivFfFQ/8+dW
         GXVfQgVynCF4TLz9Zzkuhmb6MeWRR+pmgELWdz4npE1pK7kmn2Jmwh5bKM/hj79v9MVL
         UX2rUcPywEQ7aCuHhTKdJQdlUjZM9QWZjpLieX5Vj96eRg/c4Il9UWHD4REqz3U/CncV
         eTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522329; x=1795127129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=foaFfB88socwxfhENQukeiUi552VaoZHM30SQaS2gNQ=;
        b=MMbniNexaFsgDmJh6M5+eEgGoosTuaxSBXm0mpWOG3nEsSv/xe9Z/3JRHMxkRCaOKb
         6PDXA2Y9h2hD70/kj+ph8DBmlok/19zsGk8Xa7iGHEOHC+i5/vuB0WEhEPv2pExKwSFp
         SKF0jsQpGR61G5H8VJBD3Lh6sym2Z0AVOafptmT28pzKUpCISN6wdq0MFWLL+vF7w2J7
         D3BzPkbe3kjOHeQLNIGypDRST0mx3WLuvVtGoFa1dmzcCMUhOWDtSgrr19yRRYQBqR7Y
         grsSwOmo0RIq2tGuj2bfs1r6bAWESKanY5LP4GGOhlrWlNPtiHzFp1Bq4ccCVanhNpI2
         RKHA==
X-Gm-Message-State: APuU4Z8+cQEi2lplnPtIhHKs8V7XYVcDc9YY2fxoYBiUNeh1BbS0DLgA
	Ujih2IEnMpu/25yN2i7pDo9mf1oSjiaN9rFONA5TSxCi9khdcoZnYIkex8U9DYza
X-Gm-Gg: AYBFou0DZfM/G6KC/NsfeYoNoMARNXASpCu7CmqoMbAZSSbFpizAmocBqr2/DET8hZx
	SNGVbV7w2jrbJYj2VYPd6Ah3PNMyM0Kqsr67P/RkTXmcj1Cb2K8wxkWOH4WE4mOeX5SX7dNqkUR
	XQ/w3mqFwVDW7fExXuIV4vOennuEXrEhqW9yWFGXp1XTe476sho12142fizhYd3f2o7D9D4bQrE
	YhH0+W/s12jjZszwZa1lCNso94cPIyRnQxiXUREKabunR2lvy5yA9JVdYtYNYCbzAYgW/BMdPP+
	fy8BKhPV24sArRbyf7c85hRv0q9X77I4+cXckW3jcKklutLhQ/RpVHVjCGQBoffXtNd6ALsdjOY
	qGaOr58xFyWyA9HEbZ1T+my+JovVzXvdtC/TJzMDWUT/OfV6czZj2hvmhp/INSbnb6oyGS4ARX9
	FVK+uWWGtTrbD/ZQH0uTVMzHIfy+A54SgRWpHoGUu7vqsbYB+45CRISlNnG4ZIup7E3G8GCZn8w
	jivInusCvAeckDPRCTUGdJT8rLm1xTvTxz7IAACTj+WPmOi+E6SLr46mZRgieABqpiAEb50aKa0
	fmWVejCs4pU1OlGzI+Tr
X-Received: by 2002:a05:701b:2219:b0:1b2:5ecf:9bd1 with SMTP id a92af1059eb24-1b4f5f1f0a8mr3042511c88.7.1794522329262;
        Thu, 12 Nov 2026 14:25:29 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm1718526c88.12.2026.11.12.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:25:28 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v9 0/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 22:25:25 +0000
Message-ID: <20261112222526.462146-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112173241.197996-1-takano32@gmail.com>
References: <20261112173241.197996-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v9 of the check.  The two points the review raised about the argument are
fixed, and the one about the tree is still left alone on purpose.

  - --check on a directory that is not there used to report nothing and
    exit 0, because nothing found under it reads the same as a tree with
    no bad key.  It now says so on stderr and exits 2, which is the code
    the test already uses for "could not run".
  - "--check=DIR" is taken as well as "--check DIR".  The option is read
    before the parser looks at the three positional arguments, so the
    value could be left over and taken for the table directory.

The check itself is unchanged: walk, set difference against the list of 51
keys, print the file that carries the bad key, exit 1.  On today's tree it
reports 19 keys in four tables:

  arch/arm64/ampere/ampereonex/mmu.json    PublicDescrition   16 objects
  arch/x86/amdzen4/cache.json              BriefDescript6ion   1 object
  arch/x86/amdzen5/load-store.json         BriefDescript6ion   1 object
  arch/x86/amdzen6/load-store.json         BriefDescript6ion   1 object

The point about the test checking a temporary table and never the tables
in the tree is right, and it is still not possible to add: the tree
carries the two misspellings above, and a test that fails the day it lands
is not one anyone wants.  Once the patches that fix them are in, the test
can run against the tree as well - I would rather add that as a second
step than bake a list of known-bad files into the test now.

Changes since v8:

  - --check reports a directory that is not there instead of passing it
  - "--check=DIR" is accepted as well as "--check DIR"

TAKANO Mitsuhiro (1):
  perf jevents: Check the keys of the JSON tables

 tools/perf/pmu-events/jevents.py        | 41 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 29 +++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

