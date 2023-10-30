Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388F1A710
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="pYCR1YhD";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="B272jZ5T"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD48F3
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 12:40:16 -0700 (PDT)
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id D1B6C3AB00A
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:40:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org D1B6C3AB00A
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1698694815; cv=none; b=hF+N7s7WQVvJTfsGpcrdvHhyveosk4NZVqqADHnZj//V2lhofALrgjQf+DExOHtvRZdg8fDFCzO8shPO8gnyU4UpF7UA81bzXZY/HrLCzKKFZOIjEKw1UjRWsKcmxV4GpKmanaUrum2FfzDkSdu6e/Ah4pg7/UPFFBJOgZIC6DQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1698694815;
	c=relaxed/relaxed; bh=H4C8pQpbYFCILGbYKhADmmM5ovmSWgYC8AszrU9h8JA=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 Subject:From:To; b=aI6GgmPwTdNT0fKMdckg6B41g3O7f7YcewHmHghLIm7MeIfweCfIljr5qA2COXoFhD5+0M2a0pwoM/iCKdNMD9g9/Bo2V14/xMcq2eiuFu2IN9IPaHTSNbGt2D3L0mql2lF7TU+xzCNAO/3Gb+J74IITSQAo2yScp3bo191HqEM=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org D1B6C3AB00A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1698694815; bh=H4C8pQpbYFCILGbYKhADmmM5ovmSWgYC8AszrU9h8JA=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=pYCR1YhDaFoVJ6LPX+8K92rtztsVg1G2UdBaT+2wK+16reXT/nP/26r4LNWzDX2lO
	 YoTuAXn75Fjwe8bHY+eDkzkXjlG4wtqlJzHUrc2JEp3ElNWTTshYhPapPy3fRHnwnp
	 wFGATRckiT51v3X0SG6LJhe7oCHZT5dzgbzfGBF4=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id CE0B610EE10B
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:40:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id AD2C510EE110
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:40:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org AD2C510EE110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1698694815;
	bh=H4C8pQpbYFCILGbYKhADmmM5ovmSWgYC8AszrU9h8JA=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=B272jZ5TKDMMziGDWdI7h1s7l4s7XT7oJWbwuS9mUhwOzjNXMmWlviN6NYa+olbYn
	 /bryDw1wMfi+irDEnxYOZuHW3qvnID3oljn4m3oTxGYqU+aYOcjCWqINW7R51pX7z7
	 8Na0oO35R3C5/UmZ4zuWVppLGbakO+GlSetgtTWQ=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id kNBgFqSjFJFv for <linux-perf-users@vger.kernel.org>;
 Mon, 30 Oct 2023 19:40:15 +0000 (UTC)
Received: from [192.168.0.157] (ip-86-49-236-9.bb.vodafone.cz [86.49.236.9])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 5007110EE10B
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 19:40:15 +0000 (UTC)
Message-ID: <8e97efdf-91b2-4a56-b4e5-cdc87842daef@isc.org>
Date: Mon, 30 Oct 2023 20:40:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug] nsinfo__mountns_enter failure can cause perf to operate on
 wrong file
Content-Language: en-US
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
To: linux-perf-users@vger.kernel.org
References: <4016cf84-3b11-42ee-ac88-36c1b90b1834@isc.org>
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <4016cf84-3b11-42ee-ac88-36c1b90b1834@isc.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30. 10. 23 17:42, Petr =C5=A0pa=C4=8Dek wrote:
> Hello,
>=20
> I've noticed that sometimes "perf record" confuses paths between two=20
> different namespaces and inadvertently operates on a wrong file (on the=
=20
> same path - but wrong mount namespace).

Apologies for duplicates. For some reason the previous attempts did not=20
show up in my inbox.

--=20
Petr =C5=A0pa=C4=8Dek

