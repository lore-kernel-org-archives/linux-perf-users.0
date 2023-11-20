Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HsCysVvT"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC210CB
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 10:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700505386; x=1732041386;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7q8uZR2qM3wrSgIwAkbJbBmGYC2hjQx6YxzlrSsORNk=;
  b=HsCysVvTSrKdvEqwof8SJQbU0LHRoxfnCv6ZSr5eNmw7WjBEMVM04VFe
   mIgJYPAWn6olhVekpHeq0u2OrUd0EZ/i03C6AVAvjB/EK65ElC/13hyPT
   3Q74ncmQx88JFiFBgxTRO4xobztKtZrJh/oNq01aYuGifKkDRCJMJ9stk
   0=;
X-Amazon-filename: counter-overflow-test-aarch64.c
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="c'?scan'208";a="369134113"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:36:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id C336F60CF9
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 18:36:24 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:44777]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 386bc34f-e3e7-4576-9994-d6a51df2906e; Mon, 20 Nov 2023 18:36:24 +0000 (UTC)
X-Farcaster-Flow-ID: 386bc34f-e3e7-4576-9994-d6a51df2906e
Received: from EX19D012UWC001.ant.amazon.com (10.13.138.177) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 18:36:23 +0000
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX19D012UWC001.ant.amazon.com (10.13.138.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 18:36:23 +0000
Received: from EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6]) by
 EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6%5]) with mapi id
 15.02.1118.039; Mon, 20 Nov 2023 18:36:23 +0000
From: "Ashley, William" <wash@amazon.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "Ashley, William" <wash@amazon.com>
Subject: armv8pmu: Pending overflow interrupt is discarded when perf event is
 disabled
Thread-Topic: armv8pmu: Pending overflow interrupt is discarded when perf
 event is disabled
Thread-Index: AQHaG+B2preRGLMobEe2ogRfnSWcUg==
Date: Mon, 20 Nov 2023 18:36:23 +0000
Message-ID: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-originating-ip: [10.106.239.31]
Content-Type: multipart/mixed;
	boundary="_002_950001BD490C4BAC8EEACDB9F7C4ADFCamazoncom_"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--_002_950001BD490C4BAC8EEACDB9F7C4ADFCamazoncom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F15D0AF02263D4FB66B1E5EC43516C0@amazon.com>
Content-Transfer-Encoding: base64

QW4gaXNzdWUgWzFdIHdhcyBvcGVuZWQgaW4gdGhlIHJyLWRlYnVnZ2VyIHByb2plY3QgcmVwb3J0
aW5nIG9jY2FzaW9uYWwgbWlzc2VkDQpwZXJmIGV2ZW50IG92ZXJmbG93IHNpZ25hbHMgb24gYXJt
NjQuIEkndmUgYmVlbiBkaWdnaW5nIGludG8gdGhpcyBhbmQgdGhpbmsgSQ0KdW5kZXJzdGFuZCB3
aGF0J3MgaGFwcGVuaW5nLCBidXQgd2FudGVkIHRvIGNvbmZpcm0gbXkgdW5kZXJzdGFuZGluZy4N
Cg0KVGhlIGF0dGFjaGVkIGV4YW1wbGUgYXBwbGljYXRpb24sIGRlcml2ZWQgZnJvbSBhbiByci1k
ZWJ1Z2dlciB0ZXN0IGNhc2UsIHJlcG9ydHMNCndoZW4gdGhlIHZhbHVlIG9mIGEgY291bnRlciBk
b2Vzbid0IGluY3JlYXNlIGJ5IHRoZSBleHBlY3RlZCBwZXJpb2QgKy8tIHNvbWUNCnRvbGVyYW5j
ZS4gV2hlbiBpdCBpcyBwaW5nLXBvbmdlZCBiZXR3ZWVuIGNvcmVzIChlLmcuIHdpdGggdGFza3Nl
dCkgYXQgYSBoaWdoDQpmcmVxdWVuY3ksIGl0IGZyZXF1ZW50bHkgcmVwb3J0cyBpbmNyZWFzZXMg
b2YgfjJ4IHRoZSBleHBlY3RlZC4gSSd2ZSBjb25maXJtZWQNCnRoaXMgc2FtZSBiZWhhdmlvciBv
biBrZXJuZWxzIDUuNCwgNS4xMCwgNi4xIGFuZCA2LjUuDQoNCkkgZm91bmQgYXJtdjhwbXVfZGlz
YWJsZV9pbnRlbnMgWzJdIHRoYXQgaXMgY2FsbGVkIGFzIHBhcnQgb2YgZXZlbnQNCmRlLXNjaGVk
dWxpbmcgYW5kIGNvbnRhaW5zDQogICAgLyogQ2xlYXIgdGhlIG92ZXJmbG93IGZsYWcgaW4gY2Fz
ZSBhbiBpbnRlcnJ1cHQgaXMgcGVuZGluZy4gKi8NCiAgICB3cml0ZV9wbW92c2NscihtYXNrKTsN
CndoaWNoIHJlc3VsdHMgaW4gYW55IHBlbmRpbmcgb3ZlcmZsb3cgaW50ZXJydXB0IGJlaW5nIGRy
b3BwZWQuIEkgYWRkZWQgc29tZQ0KZGVidWcgb3V0cHV0IGhlcmUgYW5kIGluZGVlZCB0aGVyZSBp
cyBhIGNvcnJlbGF0aW9uIG9mIHRoaXMgYml0IGJlaW5nIGhpZ2ggYXQNCnRoZSBwb2ludCBvZiB0
aGUgYWJvdmUgY29kZSBhbmQgdGhlIHJlcHJvZHVjZXIgaWRlbnRpZnlpbmcgYSBtaXNzZWQgc2ln
bmFsLg0KDQpUaGlzIGJlaGF2aW9yIGRvZXMgbm90IG9jY3VyIHdpdGggcHNldWRvLU5NSXMgKGly
cWNoaXAuZ2ljdjNfcHNldWRvX25taT0xKQ0KZW5hYmxlZC4NCg0KV2hlbiBhbiBldmVudCBpcyBu
b3QgYmVpbmcgZXhwbGljaXRseSB0b3JuIGRvd24gKGUuZy4gYmVpbmcgY2xvc2VkKSwgdGhpcyBz
ZWVtcw0KbGlrZSBhbiB1bmRlc2lyYWJsZSBiZWhhdmlvci4gSSBoYXZlbid0IGF0dGVtcHRlZCB0
byBkZW1vIGl0IHlldCwgYnV0IEkgc3VzcGVjdA0KYW4gYXBwbGljYXRpb24gZGlzYWJsaW5nIGFu
IGV2ZW50IHRlbXBvcmFyaWx5IGNvdWxkIG9jY2FzaW9uYWxseSBzZWUgdGhlIHNhbWUNCm1pc3Nl
ZCBvdmVyZmxvdyBzaWduYWxzLiBJcyBteSB1bmRlcnN0YW5kaW5nIGhlcmUgY29ycmVjdD8gRG9l
cyBhbnlvbmUgaGF2ZQ0KdGhvdWdodHMgb24gaG93IHRoaXMgY291bGQgYmUgYWRkcmVzc2VkIHdp
dGhvdXQgY3JlYXRpbmcgb3RoZXIgaXNzdWVzPw0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3Jy
LWRlYnVnZ2VyL3JyL2lzc3Vlcy8zNjA3DQpbMl0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2Jsb2IvYzQyZDllZWVmOGU1YmE5MjkyZWRhMzZmZDhlM2MxMWYzNWVlMDY1Yy9kcml2
ZXJzL3BlcmYvYXJtX3BtdXYzLmMjTDY1MkMyMC1MNjUyQzQzDQoNCg0K

--_002_950001BD490C4BAC8EEACDB9F7C4ADFCamazoncom_
Content-Type: application/octet-stream;
	name="counter-overflow-test-aarch64.c"
Content-Description: counter-overflow-test-aarch64.c
Content-Disposition: attachment; filename="counter-overflow-test-aarch64.c";
	size=2103; creation-date="Mon, 20 Nov 2023 18:36:22 GMT";
	modification-date="Mon, 20 Nov 2023 18:36:22 GMT"
Content-ID: <C8E4FD874567304F8CA7D582EC0CC784@amazon.com>
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8bGludXgvcGVy
Zl9ldmVudC5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlIDxpbnR0eXBlcy5oPgojaW5j
bHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNp
bmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDx1
bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGJvb2wuaD4KCiNkZWZpbmUgQ0hFQ0soY29uZGl0aW9uKSBc
CiAgZG8geyBcCiAgICBpZiAoIShjb25kaXRpb24pKSB7IFwKICAgICAgZnByaW50ZihzdGRlcnIs
ICJDSEVDSyAnJXMnIGZhaWxlZCBhdCAlczolZCAoZXJybm89JWQpXG4iLCAjY29uZGl0aW9uLCBf
X0ZJTEVfXywgX19MSU5FX18sIGVycm5vKTsgXAogICAgICBhYm9ydCgpOyBcCiAgICB9IFwKICB9
IHdoaWxlICgwKQoKY29uc3Qgc3RhdGljIHVpbnQ2NF90IHBlcmlvZCA9IDEwMDAwOwpjb25zdCBz
dGF0aWMgdWludDMyX3QgcGVyaW9kX3RvbGVyYW5jZSA9IDEwMDA7CgpzdGF0aWMgaW50IGNvdW50
ZXJfZmQ7CnN0YXRpYyB1aW50NjRfdCBzaWduYWxfY291bnQgPSAwOwpzdGF0aWMgdWludDY0X3Qg
bGFzdF92YWx1ZSA9IDA7Cgp2b2lkIHNpZ2hhbmRsZXIoaW50IHNpZykgewogIHNpZ25hbF9jb3Vu
dCsrOwoKICB1aW50NjRfdCBjdXJfdmFsdWU7CiAgQ0hFQ0soc2l6ZW9mKGN1cl92YWx1ZSkgPT0g
cmVhZChjb3VudGVyX2ZkLCAmY3VyX3ZhbHVlLCBzaXplb2YoY3VyX3ZhbHVlKSkpOwogIHVpbnQ2
NF90IGRpZmYgPSBjdXJfdmFsdWUgLSBsYXN0X3ZhbHVlOwogIGlmIChkaWZmID4gcGVyaW9kICsg
cGVyaW9kX3RvbGVyYW5jZSB8fCBkaWZmIDwgcGVyaW9kIC0gcGVyaW9kX3RvbGVyYW5jZSkgewog
ICAgcHJpbnRmKCJTaWduYWwgIyUiIFBSSXU2NCAiOiBkZWx0YSBvZiAlIiBQUkl1NjQgIiBpcyBv
dXRzaWRlICUiIFBSSXU2NCAiICsvLSAlIiBQUkl1MzIgIlxuIiwKICAgICAgICAgICBzaWduYWxf
Y291bnQsIGRpZmYsIHBlcmlvZCwgcGVyaW9kX3RvbGVyYW5jZSk7CiAgfQogIGxhc3RfdmFsdWUg
PSBjdXJfdmFsdWU7Cn0KCmludCBtYWluKGludCBhcmdjLCBjb25zdCBjaGFyKiogYXJndikgewog
IHN0cnVjdCBwZXJmX2V2ZW50X2F0dHIgcGVyZl9hdHRyOwogIG1lbXNldCgmcGVyZl9hdHRyLCAw
LCBzaXplb2YocGVyZl9hdHRyKSk7CiAgcGVyZl9hdHRyLnR5cGUgPSBQRVJGX1RZUEVfUkFXOwog
IHBlcmZfYXR0ci5zaXplID0gc2l6ZW9mKHBlcmZfYXR0cik7CiAgcGVyZl9hdHRyLmNvbmZpZyA9
IDB4MjE7IC8vIEJyYW5jaGVzCiAgcGVyZl9hdHRyLmV4Y2x1ZGVfa2VybmVsID0gMTsKICBwZXJm
X2F0dHIuc2FtcGxlX3BlcmlvZCA9IDB4MTAwMDAwMDAwMDAwMDAwMExMOyAvLyBNYXggcGVyaW9k
CgogIGNvdW50ZXJfZmQgPSBzeXNjYWxsKF9fTlJfcGVyZl9ldmVudF9vcGVuLCAmcGVyZl9hdHRy
LCAwLCAtMSwgLTEsIDApOwogIENIRUNLKGNvdW50ZXJfZmQgPj0gMCk7CiAgQ0hFQ0soMCA9PSBm
Y250bChjb3VudGVyX2ZkLCBGX1NFVE9XTiwgZ2V0cGlkKCkpKTsKICBDSEVDSygwID09IGZjbnRs
KGNvdW50ZXJfZmQsIEZfU0VURkwsIE9fQVNZTkMpKTsKICBzaWduYWwoU0lHSU8sIHNpZ2hhbmRs
ZXIpOwoKICBwcmludGYoIlBpZCAlZCBydW5uaW5nIHdpdGggcGVyaW9kICUiIFBSSXU2NCAiIHRv
bGVyYW5jZSAlIiBQUkl1MzIgIlxuIiwKICAgICAgICAgZ2V0cGlkKCksIHBlcmlvZCwgcGVyaW9k
X3RvbGVyYW5jZSk7CgogIENIRUNLKDAgPT0gaW9jdGwoY291bnRlcl9mZCwgUEVSRl9FVkVOVF9J
T0NfRElTQUJMRSwgMCkpOwogIENIRUNLKDAgPT0gaW9jdGwoY291bnRlcl9mZCwgUEVSRl9FVkVO
VF9JT0NfUkVTRVQsIDApKTsKICBDSEVDSygwID09IGlvY3RsKGNvdW50ZXJfZmQsIFBFUkZfRVZF
TlRfSU9DX1BFUklPRCwgJnBlcmlvZCkpOwogIENIRUNLKDAgPT0gaW9jdGwoY291bnRlcl9mZCwg
UEVSRl9FVkVOVF9JT0NfRU5BQkxFLCAwKSk7CgogIC8vIFRoaXMgaXMgd2hlcmUgd2UgY3JlYXRl
IHRoZSBicmFuY2hlcyBiZWluZyBjb3VudGVkCiAgd2hpbGUgKHRydWUpIHsKICB9Cn0K

--_002_950001BD490C4BAC8EEACDB9F7C4ADFCamazoncom_--
