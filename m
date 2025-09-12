Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8113043C3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680274; cv=none; b=M5+RFykOgpECxDdJrUHpMpQnYZ/+xwVEVVF5YqTU7hCJyXHP+hnENppNFg0Iwte5F5kz5mXibuASIApHyuelW1AE+MXRZQNxUaIhU176KArznkpLLHsfEy4tS+bPifIJetWlfVg9qQmyfmKYjmk0j3fXUrOZdzLm7CEFIruIa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680274; c=relaxed/simple;
	bh=+9mPX5umQxIr5Dhc5MnJCBn8tLPC55c5q9kfPczlQKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISEoRQWOei9Z7M3tqug2lnmFT690Vwi8dluriN0akOeLlSx8nSt5z8GJOdiB1MOOO0ajrQVX+mkzQEEyE2bNPQKK9D1nRi+R2CbQdDukZMHV28khRUGEY6aM5GCqMLJgoWTGgyOUxOfmmPIxvg1dE2dQvvli9q4CnxbdWyqDThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=xypa1Kjj; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="xypa1Kjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:organization:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1757680262; x=1758544263;
 bh=layHvT3O+BR0qa5UzFOiCJC5CunCUQOmYwAUn4kUAU4=; b=xypa1Kjj4CjT
 G5YFHxTGvFeMaxZ4zU3JIBWLhKU3w00JWoibXEWaaIkefJAOpFtmtIhnYs/54pru
 v8Jb82PQOuIcft/fN7N3HwYpbkJNBmMz5SkZKHQm92lnl4SH4iKmjaIXiYV/qmOE
 ZcDBOIO8xVplZNwldsvMRVb7UHXy0t8=
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: linux-perf-users@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, acme@kernel.org
Subject: Re: combined usage of `--aio -z` corrupts perf.data files - fallout
 from COMPRESSED2?
Date: Fri, 12 Sep 2025 14:31:01 +0200
Message-ID: <4137699.i63VBsrd71@milian-workstation>
Organization: KDAB
In-Reply-To: <38208379.DOZC079dcN@milian-workstation>
References: <38208379.DOZC079dcN@milian-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Mittwoch, 10. September 2025 10:51:31 Mitteleurop=C3=A4ische Sommerzeit =
Milian=20
Wolff wrote:
> Hey all,
>=20
> for some context, see https://github.com/KDAB/hotspot/issues/
> 736#issuecomment-3273734660
>=20
> The gist is the following:
>=20
> ```
> $ perf record --call-graph dwarf -z --aio -- ls
> ...
> [ perf record: Captured and wrote 0.005 MB perf.data, compressed (original
> 0.101 MB, ratio is 28.747) ]
> $ perf script
> Couldn't decompress data
> 0x598 [0xe53]: failed to process type: 83 [Operation not permitted]
> ```
>=20
> If you remove the explicit `--aio` while keeping compression via `-z`
> enabled, then the result file can be parsed. Enabling `--aio` but disabli=
ng
> `-z` also works as expected.
>=20
> My understanding so far was that `-z` implies `--aio`, and that there sho=
uld
> be zero semantic difference between `-z` and `-z --aio`. But apparently
> this was a misunderstanding on my end.
>=20
> I suspect that the above issue is related to the recent addition of the
> COMPRESSED2 record type, since commands combining both of these flags used
> to work fine until very recently.

Hello all,

there are apparently even issues with just `-z` and no `--aio`. Instead, I'=
m=20
now setting a larger buffer size:

```
$ perf record -m 16M -z --call-graph dwarf -e cycles  ./test
failed to write perf data, error: Bad address
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.138 MB perf.data, compressed (original=
=20
10.517 MB, ratio is 83.180) ]
$ perf script
failed to decompress (B): 113080 -> 16781312, dst_size 16781312 : Data=20
corruption detected
Couldn't decompress data
0x2df0 [0xb9c8]: failed to process type: 83 [Operation not permitted]
```

The code for the `test` binary used above is available here: https://
invent.kde.org/-/snippets/3549

If I use `-m 8M` instead of `-m 16M` the error above disappears. Is there=20
possibly an overflow somewhere, considering that the compressed record size=
=20
used to be only 16bit, but now is uint64 for COMPRESSED2? See:

> 	PERF_RECORD_COMPRESSED 			=3D 81, /* deprecated */
>
> The header is followed by compressed data frame that can be decompressed
> into array of perf trace records. The size of the entire compressed event
> record including the header is limited by the max value of header.size.

=46rom `perf_event.h`:

> u16				header_size;

But then we now have:

>	PERF_RECORD_COMPRESSED2			=3D 83,
>
> 8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` indicat=
es=20
> the
> total record size, including padding for 8-byte alignment, and `data_size`
> specifies the actual size of the compressed data.
>=20
> struct perf_record_compressed2 {
> 	struct perf_event_header	header;
> 	__u64				data_size;
> 	char				data[];
> };

Just a hunch, I'm not really sure this is the reason - but it does look fun=
ky=20
to me.

Note: this all happens on a linux kernel 6.16.5-arch1-1 with perf in the sa=
me=20
version 6.16-1.
=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - Trusted Software Excellence

