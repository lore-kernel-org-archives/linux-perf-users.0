Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="PfOxECst";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="M2u3dlzN"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2AA10B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 01:28:43 -0800 (PST)
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id B76FE3AB0E7;
	Mon, 20 Nov 2023 09:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org B76FE3AB0E7
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1700472522; cv=none; b=eS1S+L8/YduW9ZeVL5TibvDQ2NbwBksWZK5v2pwgaxKjVpp0tdmlPVyuNLkfzig/83SXpptkiyLpH+rEybV2Rd/1FLpab6rvtQchp2wDtUJa1R1c7Xj+WMeeCtkIqfozyjMc3eS4re1vM6forlVTaxeXf+0zSxGoxY9U9SiInRo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1700472522;
	c=relaxed/relaxed; bh=weJyDaMKbpzBCjCf1JqjUcy+04mIEr4SW7pQJzkIsLQ=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 Subject:To:From; b=RjpzJkvdZfWn3sheilp8P1ZpcjeeeDPHlnlH/lik1rU0c7CGmWfwRN5AuNr1s8bJ/Lf1SLphaBm+jP4VQ1oGF5aaKPUQNHGj9QT8wkimX+1Oofl+8UD5sDT6PwMMQZZ8zbluOcgYuj8IT8vjGL1RwWCxY38ggUuzD4XmiQHH/Ko=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org B76FE3AB0E7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1700472522; bh=weJyDaMKbpzBCjCf1JqjUcy+04mIEr4SW7pQJzkIsLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PfOxECstv8crnparc75dIuxWJBY5il+cCEL5Vz4cpONn7XYr45tJNLvuczoDMEWVq
	 +FdpcgMeL6b1NNQZdtU1EBBYBmgK4LohWZkXJSyAsw/C8vZsAfrXaAj4RB1gs+YFef
	 aIGMVrEqm9P8sdxuOVA5lOJfVo2BiIF38hqZemrA=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id B3202B85A55;
	Mon, 20 Nov 2023 09:28:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id 91996B85AB6;
	Mon, 20 Nov 2023 09:28:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org 91996B85AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1700472522;
	bh=weJyDaMKbpzBCjCf1JqjUcy+04mIEr4SW7pQJzkIsLQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=M2u3dlzNoi7LxVuoM+C5oTVac+2L0MDUe0b5yWBRnqA7JEeLUNydu8Yyhzgm4pOyI
	 OMyPAcx57j/U0/kXCbeD7I99m0iA+O8k252icUh5l4k3uffEYNVuVlL07nrHIpftWW
	 r1evmJ7BsM4dQRfhmx/UcFJ6WcJuFI4HdQZWRkoQ=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id tJvmhMbOApbd; Mon, 20 Nov 2023 09:28:42 +0000 (UTC)
Received: from [192.168.0.157] (ip-86-49-243-222.bb.vodafone.cz [86.49.243.222])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 0C0FCB85A55;
	Mon, 20 Nov 2023 09:28:41 +0000 (UTC)
Message-ID: <50dbe591-0e7d-4a76-afa5-ef82570d6582@isc.org>
Date: Mon, 20 Nov 2023 10:28:39 +0100
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
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-perf-users@vger.kernel.org
References: <3ea2cefb-7417-4cac-98fd-46325c5108e0@isc.org>
 <CAM9d7cj8E7NMnpZ3r-eeYVonQ0UJXAgp6Hpw2fTCbtF7NU=xHQ@mail.gmail.com>
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <CAM9d7cj8E7NMnpZ3r-eeYVonQ0UJXAgp6Hpw2fTCbtF7NU=xHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 06. 11. 23 5:32, Namhyung Kim wrote:
> On Fri, Oct 27, 2023 at 8:58=E2=80=AFAM Petr =C5=A0pa=C4=8Dek <pspacek@=
isc.org> wrote:
>> I've noticed that sometimes "perf record" confuses paths between two
>> different namespaces and inadvertently operates on a wrong file (on th=
e
>> same path - but wrong mount namespace).
>>
>> Version: 6.5, commit 750b95887e567848ac2c851dae47922cac6db946 from
>> Linus's tree

... snip ...

>> Values in perf output and in the containerized binary do not match. Hu=
h?
>> Where the "perf" value came from, anyway?
>>
>> Turns out the buildid-list shows value from the _host_:
>> $ file /usr/bin/yes
>> ... BuildID[sha1]=3Df53cbc885777b8cfc9e54a8015318a71e6845bc3 ...
>>
>>
>> My guess is that this can happen when the user executing "perf record"
>> does not have privileges to nsenter() the target namespace, but this
>> failure is not checked.

... snip ...

> Right, but I guess there's not much it can do in that case.
> Maybe it can warn the user it could result in unknown symbols.

 From user perspective _adding wrong_ buildid is much worse than _not=20
adding_ buildid at all.

Wrong buildit messes up output even after moving the trace into correct=20
root filesystem (or fixing permissions).

Would it be possible to detect the error & skip adding build id in that=20
case, please?

I'm happy to assist with testing as needed. Thank you for your time.

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium
