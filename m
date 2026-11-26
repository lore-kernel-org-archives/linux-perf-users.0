Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657233;
	b=fgtaUuZoasvdARwjuv2m3ut7a1Zmiy4wfZFTFxQd6qBbYlr/26E8828ZZWmGE5IBUL3z
	 QTbsH9DaNpgI1XO+1BSJtPLL1fPFPTpZuTxKlKsczUXTWWr9hhb6FwEJV902+avj/naXu
	 rRW6B4rqNcAFgM+1gb6CHYh0/kFFnVWIHdllVUaLoLXu4LHZyBcaALyMZZpE6hff2VaJy
	 oWGSpPRRqCsTNeQLgwB6I7xqskaDQiBDBgfYAtcb5tIqVTiYtaNc8Rs5UDnGK48SPmB/Z
	 oaHruM72V/UdqWJeULVxIEQt2eyI0hQ26XlH3Onr7pA4hrdFO7d0mrezkPaBPWrtWDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=hAJ8YW0Ewb1mRQ3ssYk5H7NxoMQ9JQxwtrxJFj63ZNw=;
	b=mvAh2r12ULLpUPcg48u/wyrt2oIisRqxMns0ArQMxbc9kD7DGBXeoW2Xqo2EGU1zXjXW
	 8ipQPU5NqUj9fyMivm0j5uyGMZItRhlnDvYUbrouVu3oAEVFom4mHiOp5/HGH4zLn1YXE
	 U4+ymVVS1Ta44QVMcKIU6iJfGEiGIxXOlNch7CVT2dRJgE9SmJhesyZ5MQVaNHsrlCgHU
	 A0smLjIwfhFybp3aGtYLONMkZ39rjQzrZFq1O7zIMEjOtYfs/EQ8TZ2POIIKZesVpgPMz
	 FUbqNayK1PKaP6iFKAZV0vrZGiOz6e6Y6NcBrGf+EZNnFCv1Hvo03zfd3teUmy2fTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ge4cAhfO;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8F606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 01:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA8F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ge4cAhfO
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso4002289eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 17:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795657232; x=1796262032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hAJ8YW0Ewb1mRQ3ssYk5H7NxoMQ9JQxwtrxJFj63ZNw=;
        b=ge4cAhfOUsefExKKg8KtKqLL3IUusXX48t3aPO4/OKtQ/+HU1JhJ3z3+gOu7adLoJJ
         Xp1v7SIMHrn6jg76jKnPl7uZL8jCR2Y4QyuSQOPwsjT7QKF7mzs6iHQ53QvwKdAJAEqa
         Q7qK8VsrOUzARzf6Pb8g0zzpIRev47HYtTHcR3OabojO3wuv477O3CyS3nMVh/0OJlJ3
         YfWutGcH7FDV6ddn3WuIwFnSxwQWXzTFGzYP5UcjoPPRS5fYO54F9EgbVNpONjPUkBlx
         WJ3Ncf8wBvtXBw/6pdSIyitsbqLvr4ZQZ953WoZ4032yPgBp2WUg9iYzRZIRiebOXams
         /SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657232; x=1796262032;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAJ8YW0Ewb1mRQ3ssYk5H7NxoMQ9JQxwtrxJFj63ZNw=;
        b=WFfoMnOE66JAHhfUGWNVQ7dorNELERtx0eZQgdDNqLGuexUPkFR501M5aMw3qJRIGk
         9WfbO9ZKxrVGkRrxH01lKDFfFHTheASOsCaUHzvqpOmUZp/gNP6U6NHC8W3wGrpFd4ol
         vqwd1CRbgRUSfZsQ77W/Bq0E1GnjHJ6H/u5l4tDiZJbd6xIZV9ys8kn5UuJkSCDU0u1e
         8651Q+8E+Punw8fOOJZpg+LyDLHxFvsCVcGza/g8zbGu45hXWsFAMoHiGVl5ANVvIrxq
         92aYfZq1xYJhJ1MoUziostqZxTNr/6hWSNtktv/+XaQud8h4IR/3escbpRzoZa1Vy/Y1
         +NVQ==
X-Gm-Message-State: APuU4Z/lqqzj4dRo30TyxG+eQiTOjLbI5+W7NhzdMoy7eLkbuhPDo3ES
	j5nMiO0zMIEPnBhd2bSoGurGBa+PPh+7Z3zu76C5QS2S954Avm1vdLQ4
X-Gm-Gg: AZFdTZeapzs/mkqeASmo2bDLn5/UzrgDfGztcj1enhdMfs174g3QJrdjmELb1xJTD7b
	mXMnk+v8Z3upbyXrUdNbE3u7Mj9/Xt5jHW0DIjlhZVQGuJvhJCAYJVSPhmy3is8ts2DJl19pqQC
	T70R08BXLhLGaOD4amMC8bDf53AUVOTnKaUIVtEEnTvAyDV/fIeoxNRsQISAe9sHV5hs3m8K8Px
	GomPQmX4XmxGFvHXSolqwejUyhceIgdy/c0VG4mTtn1ThZkV0bEsTMzoGkVl5wlNiFTg5o9WwKb
	39bH4y7qhsEQPRREdfejzIK8pfY8zEQSyGhlfV9oDoEde+Eh++h6/m9e32kz3lfpFqrQEP/DYr/
	/l7LRQT5kUZ4YPET9h9DeV8GWKZtp0F/f/NcRa9w6eIQ9N4Y66ltu6UlE0jcR7chQRpUT8YSMSr
	Rr53PTTtZzg62O70285JHoxsqwfNdoI7zSj2rgK80aFHrnbF1MXRIIaqpBCyMjwDlu0Q6MLf7yX
	eLIjviH9L0shXK+ukPp/JqCa/yQnQzBIn4pbJZXSzWHwbmhM9X2y69FEAeKxLU8AlS+j7HDRLg4
	elDSftvh3quwIpeityphjFxc7UA=
X-Received: by 2002:a05:7301:7187:b0:386:bd8:7ab3 with SMTP id 5a478bee46e88-3860bd88965mr19248828eec.29.1795657232084;
        Wed, 25 Nov 2026 17:40:32 -0800 (PST)
Received: from [127.0.1.1] ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm102108381eec.3.2026.11.25.17.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:40:31 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH v12 1/2] perf vendor events: Fix misspelled keys in the event tables
Date: Thu, 26 Nov 2026 01:40:29 +0000
Message-ID: <179565722975.2632881.14929987124295683126@gmail.com>
In-Reply-To: <awTB4cryDW4H4no7@google.com>
References: <20261120134250.1680522-1-takano32@gmail.com> <20261120134252.1036963-2-takano32@gmail.com> <awTB4cryDW4H4no7@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Hi Namhyung,

the series is rebased onto perf-tools-next.  The base is 148690b95cc4
("libperf mmap: Arm64: fix transposed reads of counters 12 and 13",
Ian Rogers), and it went out as v13 on 2026-11-25 in a thread of its own,
which is why it is easy to miss:

https://lore.kernel.org/all/20261125040016.1675748-1-takano32@gmail.com/

2/2 is the patch you reviewed, unchanged: the patch-id is the same
(8be9ac914f80).  1/2 now touches only the AmpereOneX mmu.json, because
the three AMD "BriefDescript6ion" entries are already in perf-tools-next
as edd09316bd37 ("perf vendor events amd: Fix a misspelled JSON key"), so
the tree-wide sweep is gone.

Thanks,
TAKANO

