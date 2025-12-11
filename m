Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DE2B2D7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Dec 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765450480; cv=none; b=XXg2vJIzS2r64GCAITu05p4ox/EsxDOn9W/YYAdN+V9dQ49l0Fsh2ErFn07naDQdmZFfi9deNFDh4GhCZ9sWoYLP5i7HdX4ab9NcJlVy4/3ST32EN5quVrSrWXlpbjU+YyXuohZKHe6GOvuqGREwWLLDivW+PvmfatJIDkQ8hWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765450480; c=relaxed/simple;
	bh=2tC1+JT5+sJz1y8I94Jz0CbHqT9KjZjtVXFJ8hmU4rA=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=JNVbVP0eXFV62RpKusrp2QEWt5kD2G4IECZNqpazlhIAoAaQcdT3b9OxO0zDhlCjDkZxe/RJbvLJ3yqh8pwd7GeDzxRX6dhZSpj9kVuWamI4BpAgv2Ep6edLyO9vcqVctv7n/d8uE2rt2X/kArQkkry3viw6HVA7ruiCiLIQA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=ZQSawmZR; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="ZQSawmZR"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AC2AQgCBJ-ETsVPPQmFlYKrr.1.1765449556480.Hmail.2200013188@stu.pku.edu.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	namhyung <namhyung@kernel.org>, acme <acme@kernel.org>, 
	mingo <mingo@redhat.com>, peterz <peterz@infradead.org>, 
	"juri.lelli" <juri.lelli@redhat.com>, 
	"vincent.guittot" <vincent.guittot@linaro.org>, 
	xujiakai2025 <xujiakai2025@iscas.ac.cn>, 
	"zhaoruilin22@mails.ucas.ac.cn" <zhaoruilin22@mails.ucas.ac.cn>
Subject: =?UTF-8?B?W0JVR10gUG9zc2libGUgZGVhZGxvY2sgaW4gX19wZXJmX2V2ZW50X3Rhc2tfc2NoZWRfb3V0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_MAC_1.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2200013188@stu.pku.edu.cn( [210.73.43.101] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 11 Dec 2025 18:39:16 +0800 (GMT+08:00)
From: Tianyu Li <lty218@stu.pku.edu.cn>
Date: Thu, 11 Dec 2025 18:39:16 +0800 (GMT+08:00)
X-HM-Tid: 0a9b0ce5650c09b6kunm9afb888b634c
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTv2670zqzAM+7RIKOqUHUUyjnjpPRHs8I0th+
	pfToBLAHHPQiSvzTUYtFIRevI3h0H/rL8uiegUHR6ncan8g2rCDfuN4NnB7NuCz/pEOsh0h8hz0y
	Vo3WCTanBTJrFVQiPyQdrhk33rDjcDAiUCX3E=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk5IVh9LTx1NS04fGEIaHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVTEhVT0hVSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkpNVUpLS1
	VKQlkG
DKIM-Signature: a=rsa-sha256;
	b=ZQSawmZRMGqzwt+G4Nd1Wunlnhgy7T1CL1+v4Vdi/ZAHGpMlKxgOhSa/ZAJbyAgyKut70/FMkhTW2jhPJc8qVVOYeGGwO0g3CTeF1BwcuohZoBQgqKqAqgu9Ta0m1G90dHOomst1RP3wUNNwGnSIzDm/hwVuAWwD5SEwjTBQMvY=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=2tC1+JT5+sJz1y8I94Jz0CbHqT9KjZjtVXFJ8hmU4rA=;
	h=date:mime-version:subject:message-id:from;

SGksCgpJJ20gaGl0dGluZyBhIHBvc3NpYmxlIGRlYWRsb2NrIGluIF9fcGVyZl9ldmVudF90YXNr
X3NjaGVkX291dC4gSXQncyBmaXJzdCBkZXRlY3RlZCB2aWEgYSBmdXp6aW5nIGZyYW1ld29yayBv
biBMaW51eCA2LjE4LjAtcmM2LCBhbmQgaXQgYWxzbyBhcHBlYXJzIHRvIGJlIHJlcHJvZHVjaWJs
ZSBvbiB2Ni4xOC4gU2luY2UgdGhlIHJlcG9ydCBpdHNlbGYgaXMgYWxyZWFkeSBxdWl0ZSBjbGVh
ciwgSSBkb27igJl0IHdhbnQgdG8gcmlzayBhZGRpbmcgaW5hY2N1cmF0ZSBhbmFseXNpcyBoZXJl
LiBJbnN0ZWFkLCBJIGhhdmUgYXR0YWNoZWQgdGhlIHJlbGV2YW50IGluZm9ybWF0aW9uIGFuZCBt
YXRlcmlhbHMgYmVsb3cgZm9yIHlvdXIgcmV2aWV3LgoKICAgIEtlcm5lbCBzb3VyY2U6IGh0dHBz
Oi8vY2RuLmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L2xpbnV4LTYuMTgudGFyLnh6
CiAgICBLZXJuZWwgY29uZmlndXJhdGlvbjogaHR0cHM6Ly9naXRodWIuY29tL2oxYWthaS9LQ29u
ZmlnRnV6el9idWcvcmF3L3JlZnMvaGVhZHMvbWFpbi94ODYvbWFpbmxpbmUtY29uZmlnCiAgICBL
ZXJuZWwgbG9nKGZ1enogcmVwb3J0KTogaHR0cHM6Ly9naXRodWIuY29tL1d4bS0yMzMvS0NvbmZp
Z0Z1enpfY3Jhc2hlcy9yYXcvcmVmcy9oZWFkcy9tYWluLzhmYWNmYmI1YWNiZTZiODJlN2I1YmY4
ZDI3YmU4OTMwMTcyYzk2YzEvcmVwcm8ucmVwb3J0CiAgICBLZXJuZWwgbG9nKHJlcHJvIG9uIExp
bnV4LXY2LjE4KTogaHR0cHM6Ly9naXRodWIuY29tL1d4bS0yMzMvS0NvbmZpZ0Z1enpfY3Jhc2hl
cy9yYXcvcmVmcy9oZWFkcy9tYWluLzhmYWNmYmI1YWNiZTZiODJlN2I1YmY4ZDI3YmU4OTMwMTcy
Yzk2YzEvcmVwcm9fcmVwb3J0MAogICAgUmVwcm9kdWN0aW9uIEMgQ29kZTogaHR0cHM6Ly9naXRo
dWIuY29tL1d4bS0yMzMvS0NvbmZpZ0Z1enpfY3Jhc2hlcy9yYXcvcmVmcy9oZWFkcy9tYWluLzhm
YWNmYmI1YWNiZTZiODJlN2I1YmY4ZDI3YmU4OTMwMTcyYzk2YzEvcmVwcm8uY3Byb2cKICAgIFN5
c2NhbGwgc2VxdWVuY2UgZm9yIHJlcHJvZHVjdGlvbiAobW9yZSBwcmVjaXNlKTogaHR0cHM6Ly9n
aXRodWIuY29tL1d4bS0yMzMvS0NvbmZpZ0Z1enpfY3Jhc2hlcy9yYXcvcmVmcy9oZWFkcy9tYWlu
LzhmYWNmYmI1YWNiZTZiODJlN2I1YmY4ZDI3YmU4OTMwMTcyYzk2YzEvcmVwcm8ucHJvZwogICAg
R0NDIGluZm86IGh0dHBzOi8vZ2l0aHViLmNvbS9XeG0tMjMzL0tDb25maWdGdXp6X2NyYXNoZXMv
cmF3L3JlZnMvaGVhZHMvbWFpbi8wZjg1ZmM2NjFhZjFlM2M2OWIyNmI5N2VhYWFhNDNkNjI5ZGU0
NDljL2djY2luZm8KCkkgaG9wZSB0aGlzIHJlcG9ydCBoZWxwcyBpbiBpZGVudGlmeWluZyBhbmQg
cmVzb2x2aW5nIHRoZSBpc3N1ZS4gVGhhbmtzIGZvciB5b3VyIHRpbWUgYW5kIGF0dGVudGlvbi4K
CkJlc3QgcmVnYXJkcy4K
