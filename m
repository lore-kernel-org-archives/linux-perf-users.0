Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798416D333
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Apr 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323013; cv=none; b=FK1ZE2ngXyKwUD5OrF6wHvuKgStXz/rH8s5kxLnZOgkAyJwuJ8nMCycAt/qzDoi5oQy6eCIT8WdPwUlmoZWrKppjuIqj7Hf/N/2TGo1b1bdYrkojDEQrh5wsLJwRMVHbYMFAHbDl/nbTloSZEbW5fZw4bJi3YPBDKeLIwTHK42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323013; c=relaxed/simple;
	bh=bBK5u7XbW+M/pfHRhUjSOQKvngvCXIaBOYYeQ0UYgcA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=DsQrXR+2GAAQsBqhi+nyCetz8pblsnd89ZoWLZdCs4Db/g/LnECVGbOo7yonXeSeoIRXoaZrKNTiTUxWCw7b0uboX0K1mxDKhV9pnGV8vhzuZG0IyjwlxgOuLi8yLkYC0ZYJ4CMZgefGzC3gGKAxJdlmz9PP7weH57EOyN99iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=O9LoGDO/; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="O9LoGDO/"
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a14:0:640:8120:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 6477260B20
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Apr 2024 16:16:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jGVgwOCOnmI0-7SoGCLJk;
	Fri, 05 Apr 2024 16:16:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712323006; bh=/omYeoe6S0OhV2BVabWzDiEhgdc2FP/rcQKRoaJu5kA=;
	h=Date:To:From:Subject:Message-ID;
	b=O9LoGDO/CHPaeR6XEa+hDDbaA/GfoX0d87Qd1ivn9b0wQXp712EDoWY9gpWt5QDyZ
	 mJAoh5CG3iJfn3JdhkeyICoAX/El7CNaK6NAo3L+47ar0h44RnDbmC4fDd1BlX2ZCD
	 MgODix+mNeiqXhAMTw8/TKXcJf2cE89uZmP2aEhM=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <83b3aa2678b7a82c4247669cd8edae4573d1f52b.camel@yandex.ru>
Subject: `annotate --data-type` is empty
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: linux-perf-users@vger.kernel.org
Date: Fri, 05 Apr 2024 16:16:45 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

6.8 release added a new feature: ability to see which struct fields are acc=
essed the
most, to figure out how to reorder them to maximize performance.

However, I am testing this with Emacs and I seem to get no results. Emacs i=
s built
with debugging information.

# Steps to reproduce

1. Build emacs
2. Record a bit of Emacs work as:

    perf mem record ./build/src/emacs --batch --eval '(benchmark-run 999999=
9 (cons 1 2))'

3. Get the results with

   perf annotate --data-type

## Expected

Information on a lot of different structs that are being used.

## Actual

There is only one struct

      Annotate type: 'struct _IO_FILE' in /usr/lib/libc.so.6 (1 samples):
      [=E2=80=A6]

and that's it.

# Additional information

* perf version: 6.8 built manually from commit "e8f897f4afef: Linux 6.8"
* `perf.data` for the testcase is 3.6M, so it definitely has more informati=
on than
  just this one struct. I can upload it somewhere if that helps.
