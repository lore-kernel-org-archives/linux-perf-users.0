Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404155;
	b=TSO49+spNVKfhTxno+z6qyXD3UiJ4u8EempUyz2f+wJEK0nWKVrpfhunqYWjTi/la4mj
	 tahtRNVBZmE4XfoKbXIYioc4DtjoyNFiohlwF0lrpvM9D4TQN4yY/wZa0j7wcKCjL2uOE
	 dM22gEEDPoZtchn3sGVwAb9Zts41lBjABZeXJeJrb0+kSFpl3hjv1221GzMVcrSbZTCV0
	 XQbWUdc/qg3M8WQG/PgzHuKXWWfc4PS0bjYwCLVUl/o2ztBFO7RoxnWVseuGxWuqVzC89
	 iKMTzYShXoAuxT/cdbRZQ1rYl5L/Xp9vXaXrCSzr4ED0bHyu/QApTPNAJ8+70lNESFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=4wr+TVHDubo7QkZWmXYb7l0IP18SbqIz/pFvG9rCN0M=;
	b=PRfNEYQ+vfjHRomL1/diGM+ppmS0WovYIdvOAiyWtf3IuLU7NjoKz3DVnAoyZ+Rdsp2M
	 AZ9yDynoUIMScxRqvfQFCTxze6SiRWFZNfiLhMn8eE1MewPA2nMI8XmwzMIHqLHE6Pw8e
	 /IhBgZD99JG/sV5s1b31LKuI3lyOYrgRmrP4KFwVuvNQfN30Cofvk49N7LKj1ElMvBrwp
	 YEjXJFp2OjrV/Km2ExXSSkGg0awyNovqYNFp/bh9/JfuBPsDZmYZqsl7h2XHR3dEcerqu
	 /0ndjgcfR0QMiQ5LfQox2EWjDGvZaC4yjo71PeovgAafpdQnYLlJlm1LEkNcKZlFPrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moqFFupm;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E1606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 13:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 999E1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moqFFupm
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so5626608eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 05:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794404154; x=1795008954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wr+TVHDubo7QkZWmXYb7l0IP18SbqIz/pFvG9rCN0M=;
        b=moqFFupmYR9lYl6wdBWqUMvCSsmLgYHZTGD5nU1AGOYQVltDTdsWdzZNMX4LjKYrY/
         kZa7Dug1IltSBlnlINkTXgUnv3ct3iUnLY08ZMTisKGWv4ECauRCeQRPPfEmiXlbKhj6
         kTMIMxQ2ubKmksn5nGhHtXvuoaghsLWtK3E8FpcoKfcpQgj+mS3Dd4rphk8mdxAnRgTt
         8+Vm+X+ApdOn8W5n8HmhsKcgTlf6B0Eg4FkRjxOYsTRaoYFRQHfYg7WZSNs+SlvdPSe9
         RHF8QBrQplbtrevs2xFfPSTnh0/QtikXGWsq6sQ5rNy4nKGQxjONb+mqXnmBGzU26cs6
         avXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794404154; x=1795008954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wr+TVHDubo7QkZWmXYb7l0IP18SbqIz/pFvG9rCN0M=;
        b=VbAa999VWSKIImkzTU/Rvl6KisP7ONVjgm5RqrNRAvBY4Wh1shGjb48R/K341IJwQ9
         vde5zOzgrK2rfTg8LXRTNHmeDUlpQoJhHlHAlj9yFj8PBtsRZprqwqNneG5qFbPGb/lj
         6rk6J6kU0ZrIATP7FixFynIOw2fpyGihUWJhuTYJ8wOofrNj63i2aTrPaCA/qoxrbDLi
         SIUFwdVKBM6Y3CokZ0phrDeKiDV9bUt3kJIWWd70rVSO9u9DYgicVq2VlcheDZhKIfB8
         vQHTQ+lfQ/wJH7HYtQ77g7XVwVltYDKBYswxqnfx/ajHzYLIPTIzCFG+rxs4/06fS9T9
         z+Bg==
X-Gm-Message-State: APuU4Z82PzWglwwzl0swbe12NWXB6HItcBJS52jWdBsvrxs0r2quXlO1
	drfZfKNEdc1pQ5NfY/Y9TRTafjYp8axkIEwK7BiRhorYdfx8PrlPfrqz
X-Gm-Gg: AYBFou3ybSamSA53Y/DYLBkL66JELcW/FPg4HtDPYt9RCR7oOmINmOKquSTTpZzA6Ki
	EYrhONq6c7uAj4199etD9E7MBmMdasAL904CzGO4QdR+NqH3WhJhOeElnpZrG053Unzv4pAdauW
	bK8LamOhqtYHqHILTFY+aa7OE/OdJV68yLImPn/s00jSn6sSFiX1QHRibVtZOobog5lIFMEr8nI
	eO7bF50YEHxQ309RRDO5MrPRPBVPJWOlZoWU1ZC7sE/8QMbjUi4epcuzYHZFT+GeVfLZfaodoXS
	leRVRCjxYxtR+BtFZ+6Dc9Hv6RJahDACCo9K0Qg2uDWVKVszAkQgaPl4A/VNg3KLsb8RsW4v90n
	JHYHZH/j8AJ5/f6GAd+O6Bfy8ChfIdGjvs2FyKsJEpOVv/Dt2py0q+Vj61wBn8hBDYH0FPBreDV
	oBm99tPCgeaSZDuvQShYSqQkZvt5cYy5j03QH06OMU0NupLNhXcU0cP9hbrxAi1E2BVLOAup99E
	U9g78iVtb7AxzzYX1svB5hYxQ4uECw3tZYMwstdiIl6PCCjTOxDaVX1GzV/bJz/sl7SHI/UTdLi
	P5shRC6hFVqf9zrplgqgVvjEgHk=
X-Received: by 2002:a05:7301:db15:b0:375:b560:a323 with SMTP id 5a478bee46e88-3768366a43cmr3063455eec.1.1794404153449;
        Wed, 11 Nov 2026 05:35:53 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9d78sm17768172eec.25.2026.11.11.05.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:35:51 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, John Garry <john.garry@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix misspelled PublicDescription keys
Date: Wed, 11 Nov 2026 13:35:48 +0000
Message-ID: <179440414898.2353714.11591904089911934138@gmail.com>
In-Reply-To: <39ac224f-2903-496e-9a08-b4c5a33dc87f@linaro.org>
References: <20261108183846.3804875-1-takano32@gmail.com> <bf6925f6-613f-4e20-8491-2a99183f34fb@linaro.org> <39ac224f-2903-496e-9a08-b4c5a33dc87f@linaro.org>
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

On 2026-11-11 10:16, James Clark wrote:

> IMO I would rather have something that's incredibly strict and simple,
> or nothing at all. Having to work around edge cases and report near
> misses doesn't sound great.

Agreed, and the near-miss report is gone.  The series is posted again:

https://lore.kernel.org/linux-perf-users/20261111132622.2349165-1-takano32@gmail.com/

The check is now a fixed list of the 51 keys a json object under arch/ may
carry: 47 of them jevents.py reads, one more metric.py reads, and three are
read by nothing although the tables hold them (Counter, CountersNumFixed,
CountersNumGeneric).  A key outside that list is reported with the object
that carries it.  There is no cut-off, no similarity and nothing that
depends on what a run of the generator happened to read, so there is no
edge case left to work around.

It still runs as "make check-jevents" and as a perf test rather than as part
of the build, and on the tree today it reports exactly the two misspellings
we have, the 16 in this file and 3 in the AMD tables, so it wants those
fixes in front of it or together with it.

The one thing I did not do is put the list in a json schema file, because
perf's build would then require jsonschema, which it does not use today and
which is not in every builder's python.  The list holds the same names that
a schema with "additionalProperties": false would say.  If you would rather
have the schema file and take the dependency, it is a small change from
here.

