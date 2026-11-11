Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409765;
	b=ZycBjnHbVru4vJYS+iuyd7JlDaUStAgzWFeQRpQghDmAPn0gtuij6V2abjlw2NgpUJGq
	 IcPRm+JVas232ald1ksb5hryimKjk4miXZ1uuBrnGTRJkNhyHMPKR4z9WQ5NBLzpUOMvK
	 IpL+4mr2xklLslmqkA+BufwGO9p3djr8bRVCAzPLn2/CRwLE1o8Z7NFTLGxxy3TQ50q+l
	 1lldb3LBT7LfH+u3LYyDicRKn2PpsYLGd6VnQSfdYwP8/DN4wkkE9mJzhyOeTk3E6lz5u
	 mX/V1oLTb74qVVe0UuDc/7u1wwfrY27nvKDeSl1qmm2+Lx6CgT2nGwiF2/Uqa6UI60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9H00IDU3aQoHzyRtBc+G3tODp+JOa8K7pKLVcbeYNgs=;
	b=LMNNLnSG3oiA+dJyVq5WNZJpnEwCgKxMXkpeAO9F8FETFTO+iLa3etYiMonC24GJMoE2
	 EAHVIRr2kNx611IMP2qjppAr5TFKS/+6gugPumXgxd1iY8aPkhjbMPxJTbo409crB49Ql
	 Ef8+2l/Mh7H2mIdeBdz/+R/98UOOlHC7eIWk+r/TO4jzXGQ9+aRzXRML6XLreylYnKZ91
	 i8TgaeZUtB8pWWZYcOj99RpPyMhecFmj+PRaDNC9b7KmMoWgrJiUMtJ2gC7U+yD3RurwL
	 A0mMRxiVlDLt0UhmJQp162SJ5d9lJ+1SdUCDqUP1ZS5xcNK+Z7YlCJ4RnHGnkvaLplg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ki+DmLG5;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50300606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 15:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50300606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ki+DmLG5
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1532490eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794409764; x=1795014564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9H00IDU3aQoHzyRtBc+G3tODp+JOa8K7pKLVcbeYNgs=;
        b=Ki+DmLG5Y40SW4rutyKKupGpP6/fFoWvEWkTZ9H2DuKmcrEMCbOfsD+9/f/b9/b6/+
         UPgeMmnEmvZOECPyzhZR34Iryl8sAg8WrhAXOgOjiQ/qdFCiE7ZTD/M7CroX7zJHt80e
         Jgw4OIeYCJA4QixPzY7a2snB3shpu8sDABeLaTJUfzhh97VU9XUle4JragrRCcWnVFTi
         GRsy6UvPrX1jlEnGNLwn70DdHHSqslkHSQJ5bLG3xZJ5Bi/VDMuxxQHGMTKvdm+uIMSj
         aEypDQDB6lwA84vZF4BTQPCcbhueRB2sZodBVLiXY05PQiVaD0faTSM7+aM47q9mVgkA
         sYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409764; x=1795014564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9H00IDU3aQoHzyRtBc+G3tODp+JOa8K7pKLVcbeYNgs=;
        b=nzL/UKGK9lUpYoNspgZJJYx8O/doiO6JkHAfX5jn3JLhK+mrDIM9HVSyV2VKJcKozI
         zLtoqtHkSr1hSknUBu9VcAC+gMS0SxuqDokzHvThcaao6MEY8dLNwf43SXLajGoHrUEQ
         9KEeFI5Lwij7SGoWp78wg/TrDduXtgI0r7PbnJR7Cc+j+8rsM0PJewWarYUhJXQUJAID
         aTd1M0v4kcLnXSLxdiJCiUkU66HKCXO2IjDgtkDTig5HoVJkW7Zrp4BM7U6e0Y4CtoeX
         QOjC6/MFBLZNdeKB6lCoef03+/iZ7UDQ/4rfCC5uXPg+Oth/FkAtclMJk7k0ut+a2NLo
         cBUA==
X-Gm-Message-State: APuU4Z/FFkedThq5TlEqMJZud0QEZOs7Ku4PiZeUqc5j6A6aGZbF+jlg
	Az8MpaAV4odR4ogrwXo+mTR53Nfo3cHNog9HI1QAUKbacPHZV3aa9XCJHpmfSx/n
X-Gm-Gg: AYBFou2wI7dqA+YGM0f1kkiT7jHucSoCbZb9H9lgAcWN//5JztN/N6bQmzOqiqd/i4B
	RTduF5fX6jQcgK8DSQqguZ0W2DX/qwDTwAzfsjUVZPJJmt9e28W3Qi03drFgajyALtkTemxUcHU
	+WeiweYWRbkWJeyNHh4snVQICGIHYgMuAFeYcEdF9HjaP4G72hclt3b8hsxVbLvvsjp+wDGLdtV
	zzCneYh4U63oKWd8xbuJ2TrNP2WgQlUYKbA+kFmivbFrQoiBOeSmp07Usqun9SJvZtqGDSaMIh9
	RVC4W1eNIUnqTU4f2zvYsbkD+Mssb9aWh3BUrRFf1NPr1oJUPi2Fb5DqD32MJY7v5QDNRNLCJ+1
	2r/l5SyRrl7zUiHx5cSd2K794hA8q6nJNFOD0K5ukcGDRat+T1fL9PXN+IVNaISCfAX18ZULtU6
	FaJc2E3nD0sVwStdfvw8mKFe1enw3WzWPoGmDB9/jDTJtwPPLWJRz7huBF1eJwJhmOCOvEp1LKI
	zVgARRSlZavkLpKh7NIS3kEZapDqpH4Ii6IaAYjKHqeokqPw70lC7Pms+RA1wSeQefne3WxllIE
	dDfv1f7b78h7w6cVF17Gc1ebp1nRNYenKAoD6+z1AQ==
X-Received: by 2002:a05:693c:65d5:b0:36a:1f8:a5a4 with SMTP id 5a478bee46e88-37687213f9dmr3346276eec.38.1794409764295;
        Wed, 11 Nov 2026 07:09:24 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm18162507eec.27.2026.11.11.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:09:23 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v6 0/3] perf jevents: Check the JSON keys a table may carry
Date: Wed, 11 Nov 2026 15:09:17 +0000
Message-ID: <20261111150920.2383157-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111132622.2349165-1-takano32@gmail.com>
References: <20261111132622.2349165-1-takano32@gmail.com>
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

jevents.py takes the fields it wants out of each JSON object by name and
ignores the rest, so a key spelled differently is dropped without a word
and the object is built without whatever that field held.  Two of those
are in the tree: "PublicDescrition" in 16 entries of an Arm table, where
the lost long description repeated the brief one and so nothing a user saw
changed, and "BriefDescript6ion" in one entry each of three AMD tables,
where the event is generated with no text at all.

Patch 3 says which keys a table may carry and checks the tree against
that, instead of reporting the keys a run of jevents.py did not read.  The
list is 51 names, 47 of which jevents.py reads, one more of which
metric.py reads, and three of which nothing reads although the tables hold
them (Counter, CountersNumFixed, CountersNumGeneric).  A key outside the
list is reported with the object that carries it; there is no cut-off, no
similarity and nothing that depends on what a run of the generator
happened to read.  It is not a JSON schema because perf's build would then
require jsonschema, which it does not use today and which is not in every
builder's python; the list holds the same names that a schema with
"additionalProperties": false would.

The other two patches are small reader fixes that came out of the same
work, and patch 3 stands on its own if you would rather take only the
check:

- patch 2 makes the model argument optional, so "jevents.py x86 <dir>"
  runs by
hand, which is how the check was tried out.
- patch 1 stops the generator from dying with an AttributeError on a
  metric
that has a name and no MetricExpr, which is the same kind of silent JSON
problem, and names the metric and the file when it does.

The single patch posted first (20261110193239) was version 1 of this
check, before those fixes were written; v3 turned it into a series and v5
replaced its body with the list above.

v6 changes two things the review found.  Patch 1 now names the file as
well as the metric, because the tables are read through a worker pool
outside the directory walk and the path was lost on the way out.  The
test's one-line description ends in "(no_mlock)", so perf test lists it
whole and the test does not take a memlock slot.

The check still runs as "make check-jevents" and as a perf test rather
than as part of the build, so the generated tables are byte identical, and
on the tree today it reports exactly the two misspellings above, which are
posted separately.

Link: https://lore.kernel.org/linux-perf-users/20261108183846.3804875-1-takano32@gmail.com/
Link: https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/

TAKANO Mitsuhiro (3):
  perf jevents: Name the metric and the file when a MetricExpr is
    missing
  perf jevents: Make the model argument optional
  perf jevents: Check the JSON keys a table may carry

 tools/perf/Makefile                     |  13 +-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 229 ++++++++++++++++++++----
 tools/perf/tests/shell/jevents_check.sh |  61 +++++++
 4 files changed, 272 insertions(+), 32 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

