Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F230DEDC
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050779; cv=none; b=SP5hilRct0ig8BiYIcaiJ/DAYlb92V5ECv0salZujzV3rjsvaed87IA+Mi34Ofl85pcpm0TG0DIXMGb6Egp6IOakr3oHqamgr6p9ohlH6YYEYckSreyJlHHavueIjtmO0KiWfI9CXFjIhdA1OOPg8WdSxbCIX4pV5BaTg+humQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050779; c=relaxed/simple;
	bh=jwhTYka1e9iOmx2SVj6yoU8pT4b44dF31kLmN4yoxeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gMboyDiy3koWcQ1K6NGgf5ZMldcogZR5VB+DwpMRkAh2ch0jlDCqS51pGmkzHvQezLHNlJpPAJJXQvf2MBZMNwF6eAomLoGSMMqU0KWQnBuib99Dbm/qPyg+i0MO00SEoCVe7stwI8Jq6EOG2l2QiQmvXv3dtZoF/2V7lZ3zJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ouef1GIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouef1GIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30D3C19425;
	Fri, 24 Apr 2026 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050778;
	bh=jwhTYka1e9iOmx2SVj6yoU8pT4b44dF31kLmN4yoxeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ouef1GIrSN0pXA8XquX1h3Lf27YciMKt/g4N8V907GAIDyU0kXoGNWzoIcKBHPNjR
	 l5B7e2ql8uJ7d4f5+YXFTPAHvCfZJ35WMIKC3lxDlMHcZI2krM3rmaAQH8O08b6mgj
	 aruK+ONuw5kVLyhNld2A/wuXks4q4LZVMvn1oCgFmKrYmQzp6ejd1Z1tDHujmObauX
	 9trt1E3mKgnxPHKOJiUf3bjNgIxVdQjh7kGiSLFPHI1E7M6Mkj9k++4FiuVg3Xy85l
	 Qet+CYh4qcJrvcRAwAy4NAsY6oV1Q3PcXG/PUEucGl7uiDiCZAiIxcBCQhOD2NFDI3
	 kOHcvQv9RXHhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 35/58] perf event_analyzing_sample: Port
 event_analyzing_sample to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-36-irogers@google.com>
References: <20260424164721.2229025-36-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:12:57 +0000
Message-Id: <20260424171258.C30D3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Severe performance degradation due to SQLite autocommit mode on pe=
rsistent disk.
- [High] Uncaught OverflowError during SQLite insertion crashes the script.
--

commit a442452d2a68e67232b1b0da214a636360cd4afa
Author: Ian Rogers <irogers@google.com>

perf event_analyzing_sample: Port event_analyzing_sample to use python modu=
le

This commit adds a port of the event_analyzing_sample script that uses the
perf python module directly. This avoids creating intermediate dictionaries
for all event fields, resulting in faster processing.

> diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/pyt=
hon/event_analyzing_sample.py
> new file mode 100755
> index 00000000000000..7507917e16be37
> --- /dev/null
> +++ b/tools/perf/python/event_analyzing_sample.py
[ ... ]
> +def trace_begin(db_path: str) -> None:
> +    """Initialize database tables."""
> +    print("In trace_begin:\n")
> +    global con
> +    con =3D sqlite3.connect(db_path)
> +    con.isolation_level =3D None

Does setting the isolation level to None cause a performance regression now
that the default database path has changed to a persistent disk?

With the default path changing from /dev/shm/perf.db to perf.db,
disabling implicit transactions means every insert statement executes
as its own transaction. This forces a disk sync for every single event
and can cause massive overhead for typical traces.

Would it be better to remove this isolation level setting and explicitly
commit the transaction in trace_end() instead?

> +    assert con is not None
> +
> +    # Will create several tables at the start, pebs_ll is for PEBS data =
with
[ ... ]
> +def process_event(sample: perf.sample_event) -> None:
> +    """Callback for processing events."""
[ ... ]
> +    # Create the event object and insert it to the right table in databa=
se
> +    try:
> +        event =3D create_event(name, comm, dso, symbol, sample.raw_buf)
> +        insert_db(event)
> +    except (sqlite3.Error, ValueError, TypeError) as e:

Could this exception block miss an OverflowError on 64-bit unsigned integer=
s?

If the event status has bit 63 set, the sqlite3 driver will raise an
OverflowError since it natively supports up to 64-bit signed integers.
Since OverflowError inherits from ArithmeticError, it bypasses this catch
block and terminates the processing loop prematurely.

> +        print(f"Error creating/inserting event: {e}")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D35
