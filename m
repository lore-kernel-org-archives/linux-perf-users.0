Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409769;
	b=s50xpL1hz8159ncdPYM0TJB2pRpg25TFyLriXfB2Z33mxubY9MP9cqIddIPy9C8AjRI4
	 GEQXHIZZdgJ+8nneABoYobUi95dzhHV8kXgER4/xuonfWFBKdtXae45ZpfX9eTSPZXKNl
	 1ftKoxQgDwHg99f8hIy7efHwwGQjAFC146Aq2MKT1TALB+7dukyM/qtnemDcjUfN4bApM
	 yei3XNU6gD3ItHBP29RCncwsfNho9j4eOs7e5dyV8jzAGdJfUTOOYGRok3KsKTegBVMMl
	 4K0DD43sX1Hk8zpCPLyWvymXdpzliZYSWmcSG66yBWim3BhfjKIsGOwW4+dIu6Gqm0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AFn/Qw0D3tKs9pUdfzOYxJpfxee+cN+QZfY+pRX46I8=;
	b=YPWDuXbFmBai6WjS4CD4BXZ7xqmcEFFYVpbFGklBoIm//iS7y1s7Z3N3rbxvZhd7QpKc
	 v2JyoZk0GWeRGnqNjOXImgmZMGoJ7I0qWKeFZyE9FxwouuKbohdVL4Vgo7KcLblNcVaNQ
	 7jjQPbuDsqckXJxSgf5X4wos7vxgJs4mcSuLYRzPfamDsGT5hhoLh9HBtqBZjGTB9E5nT
	 uT8M3g3sX3H5YPwegNa90c9oqV5mXygzVaFJoy5xjxlDbbmulA5zGMfzJx5/xrgixuMPQ
	 I7JskLdZmDSfLcOKZekkbUOfGyw3vtLGb78IKbC9tF2tsm79zhpql2Y3d8OLcqzXWHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZXYVgsKA;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205960A3823
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 15:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4205960A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZXYVgsKA
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso6761188eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794409768; x=1795014568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFn/Qw0D3tKs9pUdfzOYxJpfxee+cN+QZfY+pRX46I8=;
        b=ZXYVgsKAk53qpttghbRMIXr7FeIApxCdrrH5CUxEEYfIcTnDtKR1TyYgkxV0xfPJaN
         h/4230sx5P/vx0q/HCkOF2ma8+Oh3jYVQuXN15lKY8SEljtBtmjOaQJKigL0yi9b+6cf
         /N2jKjlGDGCGOMCJcctreLbIcMi2FJkvS6wr1IC6z5zF+HnC2+dw15nWkD1OuiCPj1lA
         mISqryPmIabtUharqu7kdqR7YMAhvJo2axhdGxJnZVnJ+2B3g8KVjdN8VPvepu9fI5r2
         0W81Ze2uE9hSlfmPm46XxeTssmRJ+48yudBf6CxtCAC4/EVrAQMwFdULEHW4OWkK7x2R
         D+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409768; x=1795014568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFn/Qw0D3tKs9pUdfzOYxJpfxee+cN+QZfY+pRX46I8=;
        b=WpxbtPtpUHMbtxk21D085j9kTzQ4n5XsAh/DI7qL7YgmRtxNqm2PpEEanbf7GzFcoQ
         7V3eSHyMqryll3ozTGD5Qhl0Y/qzClxxxzQ33ZMlXymNt1S7YeJFGuTx9ajB1/vCZZgT
         gxvVdF8940f/Tgj4k/r7/eSeXndjQjblf0qskZlJ22dyCFP1LijGIoMs3wWX75VQby0V
         4OdB7jo4v5/BH4w8V8CvPTl4aWaWMwXbDKTU8q2yJ8Y61lXGAClzVOKL8y2g3YwyMQ4g
         eOiRYusvfhGfgt6xdIN+jYiP5UmU8Jhudng8cgNG7UHkT+lcXSZDGyNA5Byfwe40u4nS
         13CA==
X-Gm-Message-State: APuU4Z9jbfy7HrWvfNbun1F4eAAg4q5s1kdv8+iwRBiUb4sOGFwdqm9F
	8tSWDckqUx8PWEXD9g04ri+cdBADzcchBxCWxigR9U44B/pxto5vZHJM3pMzaSyM
X-Gm-Gg: AYBFou3esiHj6aeSUlQNJuSk33FDheXdvD+tp/84/r7RhNLYgwlKQ8GYcy3DmffF52k
	/kMKGfWDEmfQfVkMdCAofx6XTTRMBU43sCA+wfiLngOxuXOCGUPt0urEQlI4xW/4DbLHhBx2zEF
	Wb+2MiXCUmGeyyUINRYZTFyHECnLYQiqMzPYOWQB/0x5kYGPfNEQ0QqDOOcvk7YLExaA2oVTrdR
	1Qg2VdZPSsTijiDbiAq/S2Z9Up7YmarRr9pSwV2kNXQrV41tGlJdyqWOzW8xbPM226e0iidmiEM
	Xd2Bm3PIvRvSy0Oa5ROCchkquIz66zcIn6Sq0d+zcbhauORRTO/fUKtHPG53PcWE5X5tQ4gjjJt
	mDSl/dV97alpjAXXyZebrUgB9n4bIz8FPxlwe3cCIp11IzhKoVsUDjDZXkq7LIULEGfc7zcZs1t
	lLfIvaIMADieQXy2xTcXmI5EQ4qjIEfSk8DYF9fVVMmg/aMQAs27BjUGuJp0qMa00Ii6Rzf8Him
	zZv7WygoK5ux5asAXZhfMuNbHZaIFaTH106gbsyxy1VpZ9GdvRgTfS5DvC2pg4OwcXjvsFx2oMe
	CiUSjhsgurGW+li1KL1o
X-Received: by 2002:a05:7301:fa0d:b0:36a:1294:59e0 with SMTP id 5a478bee46e88-37685c7ab1amr3814775eec.24.1794409768204;
        Wed, 11 Nov 2026 07:09:28 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm18162507eec.27.2026.11.11.07.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:09:27 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v6 2/3] perf jevents: Make the model argument optional
Date: Wed, 11 Nov 2026 15:09:19 +0000
Message-ID: <20261111150920.2383157-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111150920.2383157-1-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
 <20261111150920.2383157-1-takano32@gmail.com>
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

The model argument carries a default of "all", but a positional argument
with a default and no nargs is still required: "jevents.py x86 <dir>" exits
with "the following arguments are required: model", and so does any caller
that only wants the tables for an architecture.

Make it nargs='?' so the default is reachable and an omitted model means
"all".  Builds pass it explicitly, so the generated tables do not change.

Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v6: patch 1 names the file as well as the metric when a MetricExpr is
    missing (the tables are read through a worker pool, outside the
    walk, so the path was lost).  The perf test's one-line description
    ends in "(no_mlock)" so perf test lists it whole and the test does
    not take a memlock slot.  No other change.

 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 843748915c12..04ef2f488283 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1487,10 +1487,10 @@ def main() -> None:
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
-  ap.add_argument('model', help='''Select a model such as skylake to
-reduce the code size.  Normally set to "all". For architectures like
-ARM64 with an implementor/model, the model must include the implementor
-such as "arm/cortex-a34".''',
+  ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all", and that is what an omitted
+model means. For architectures like ARM64 with an implementor/model, the
+model must include the implementor such as "arm/cortex-a34".''',
                   default='all')
   ap.add_argument(
       'starting_dir',
-- 
2.53.0

