Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2119047F;
	Sat, 15 Mar 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019466; cv=none; b=di5k1YguDARQbER/1cfqgFp9LwMXpKDVEMq9VzBAZd7qrcMplfHKaDsWealCjsWWmbvyvDJXEQc2vcn632Z12th+zcUhW8iLdO8MAQxaCGoW2c1C/8tYCYhS5nh51m4V4RwHyAQUPaYzE8YHiFfOXXlHxFbXkVXd5VfF2noEBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019466; c=relaxed/simple;
	bh=aReZxqbqDIlPLTR0LMZveH1dNEBv83blpitHwO14rHM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=D1yEiiS5ZBt6OJlT9PSOQR5vKicc0A3YH3fJjqDRyuTamAZy5jB1Bt6FtnyeBMB5HFsG5s/Pg7LjoCWPNSiumskn7Y86T/nluPo3SapzFBmiOVdFoBpNT+KHceFrCVMznn83yvK2jFMFSHT3q98PWtY7MEpkP2621MNm/3HbtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZF9yB6MTWz501gZ;
	Sat, 15 Mar 2025 14:17:38 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 52F6Ha9R055411;
	Sat, 15 Mar 2025 14:17:36 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 14:17:38 +0800 (CST)
Date: Sat, 15 Mar 2025 14:17:38 +0800 (CST)
X-Zmail-TransId: 2afc67d51b821a3-67f97
X-Mailer: Zmail v1.0
Message-ID: <20250315141738452lXIH39UJAXlCmcATCzcBv@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <peterz@infradead.org>
Cc: <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBlcmYvY29yZTogdXNlIHN5c2ZzX2VtaXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50ZigpLg==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 52F6Ha9R055411
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D51B82.006/4ZF9yB6MTWz501gZ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogWGllTHVkYW4gPHhpZS5sdWRhbkB6dGUuY29tLmNuPg0KDQpGb2xsb3cgdGhlIGFkdmlj
ZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2ZzLnJzdDoNCnNob3coKSBzaG91bGQg
b25seSB1c2Ugc3lzZnNfZW1pdCgpIG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcN
CnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNlLg0KDQpTaWduZWQtb2ZmLWJ5
OiBYaWVMdWRhbiA8eGllLmx1ZGFuQHp0ZS5jb20uY24+DQotLS0NCiBrZXJuZWwvZXZlbnRzL2Nv
cmUuYyB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9ldmVudHMvY29yZS5jIGIva2VybmVsL2V2
ZW50cy9jb3JlLmMNCmluZGV4IDk2Zjk1NzAzNWM2ZS4uMjA5MjUwZjQ4NTFhIDEwMDY0NA0KLS0t
IGEva2VybmVsL2V2ZW50cy9jb3JlLmMNCisrKyBiL2tlcm5lbC9ldmVudHMvY29yZS5jDQpAQCAt
MTE2OTgsNyArMTE2OTgsNyBAQCBzdGF0aWMgc3NpemVfdCBucl9hZGRyX2ZpbHRlcnNfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQogew0KIAlzdHJ1Y3QgcG11ICpwbXUgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCiANCi0JcmV0dXJuIHNjbnByaW50ZihwYWdlLCBQQUdFX1NJWkUgLSAxLCAiJWRc
biIsIHBtdS0+bnJfYWRkcl9maWx0ZXJzKTsNCisJcmV0dXJuIHN5c2ZzX2VtaXQocGFnZSwgIiVk
XG4iLCBwbXUtPm5yX2FkZHJfZmlsdGVycyk7DQogfQ0KIERFVklDRV9BVFRSX1JPKG5yX2FkZHJf
ZmlsdGVycyk7DQogDQpAQCAtMTE3MDksNyArMTE3MDksNyBAQCB0eXBlX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqcGFnZSkNCiB7
DQogCXN0cnVjdCBwbXUgKnBtdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KLQlyZXR1cm4g
c2NucHJpbnRmKHBhZ2UsIFBBR0VfU0laRSAtIDEsICIlZFxuIiwgcG11LT50eXBlKTsNCisJcmV0
dXJuIHN5c2ZzX2VtaXQocGFnZSwgIiVkXG4iLCBwbXUtPnR5cGUpOw0KIH0NCiBzdGF0aWMgREVW
SUNFX0FUVFJfUk8odHlwZSk7DQogDQpAQCAtMTE3MjAsNyArMTE3MjAsNyBAQCBwZXJmX2V2ZW50
X211eF9pbnRlcnZhbF9tc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiB7DQogCXN0cnVjdCBw
bXUgKnBtdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KIA0KLQlyZXR1cm4gc2NucHJpbnRmKHBh
Z2UsIFBBR0VfU0laRSAtIDEsICIlZFxuIiwgcG11LT5ocnRpbWVyX2ludGVydmFsX21zKTsNCisJ
cmV0dXJuIHN5c2ZzX2VtaXQocGFnZSwgIiVkXG4iLCBwbXUtPmhydGltZXJfaW50ZXJ2YWxfbXMp
Ow0KIH0NCiANCiBzdGF0aWMgREVGSU5FX01VVEVYKG11eF9pbnRlcnZhbF9tdXRleCk7DQotLSAN
CjIuMjUuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogQXJp
YWwsIEhlbHZldGljYSwgJnF1b3Q7TWljcm9zb2Z0IFlhaGVpJnF1b3Q7LCBzYW5zLXNlcmlmOyBi
YWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5Gcm9tOiBYaWVMdWRhbiAmbHQ7
eGllLmx1ZGFuQHp0ZS5jb20uY24mZ3Q7PC9zcGFuPjwvcD48cD48YnI+PC9wPjxwPkZvbGxvdyB0
aGUgYWR2aWNlIGluIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0OjwvcD48cD5z
aG93KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hl
biBmb3JtYXR0aW5nPC9wPjxwPnRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNl
LjwvcD48cD48YnI+PC9wPjxwPlNpZ25lZC1vZmYtYnk6IFhpZUx1ZGFuICZsdDt4aWUubHVkYW5A
enRlLmNvbS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO2tlcm5lbC9ldmVudHMvY29yZS5j
IHwgNiArKystLS08L3A+PHA+Jm5ic3A7MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSk8L3A+PHA+PGJyPjwvcD48cD5kaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50
cy9jb3JlLmMgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYzwvcD48cD5pbmRleCA5NmY5NTcwMzVjNmUu
LjIwOTI1MGY0ODUxYSAxMDA2NDQ8L3A+PHA+LS0tIGEva2VybmVsL2V2ZW50cy9jb3JlLmM8L3A+
PHA+KysrIGIva2VybmVsL2V2ZW50cy9jb3JlLmM8L3A+PHA+QEAgLTExNjk4LDcgKzExNjk4LDcg
QEAgc3RhdGljIHNzaXplX3QgbnJfYWRkcl9maWx0ZXJzX3Nob3coc3RydWN0IGRldmljZSAqZGV2
LDwvcD48cD4mbmJzcDt7PC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+c3RydWN0IHBtdSAqcG11ID0gZGV2X2dldF9kcnZkYXRhKGRldik7PC9wPjxwPiZu
YnNwOzwvcD48cD4tPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4g
c2NucHJpbnRmKHBhZ2UsIFBBR0VfU0laRSAtIDEsICIlZFxuIiwgcG11LSZndDtucl9hZGRyX2Zp
bHRlcnMpOzwvcD48cD4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1
cm4gc3lzZnNfZW1pdChwYWdlLCAiJWRcbiIsIHBtdS0mZ3Q7bnJfYWRkcl9maWx0ZXJzKTs8L3A+
PHA+Jm5ic3A7fTwvcD48cD4mbmJzcDtERVZJQ0VfQVRUUl9STyhucl9hZGRyX2ZpbHRlcnMpOzwv
cD48cD4mbmJzcDs8L3A+PHA+QEAgLTExNzA5LDcgKzExNzA5LDcgQEAgdHlwZV9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKnBhZ2Up
PC9wPjxwPiZuYnNwO3s8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5zdHJ1Y3QgcG11ICpwbXUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTs8L3A+PHA+Jm5i
c3A7PC9wPjxwPi08c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybiBz
Y25wcmludGYocGFnZSwgUEFHRV9TSVpFIC0gMSwgIiVkXG4iLCBwbXUtJmd0O3R5cGUpOzwvcD48
cD4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4gc3lzZnNfZW1p
dChwYWdlLCAiJWRcbiIsIHBtdS0mZ3Q7dHlwZSk7PC9wPjxwPiZuYnNwO308L3A+PHA+Jm5ic3A7
c3RhdGljIERFVklDRV9BVFRSX1JPKHR5cGUpOzwvcD48cD4mbmJzcDs8L3A+PHA+QEAgLTExNzIw
LDcgKzExNzIwLDcgQEAgcGVyZl9ldmVudF9tdXhfaW50ZXJ2YWxfbXNfc2hvdyhzdHJ1Y3QgZGV2
aWNlICpkZXYsPC9wPjxwPiZuYnNwO3s8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QgcG11ICpwbXUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTs8
L3A+PHA+Jm5ic3A7PC9wPjxwPi08c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PnJldHVybiBzY25wcmludGYocGFnZSwgUEFHRV9TSVpFIC0gMSwgIiVkXG4iLCBwbXUtJmd0O2hy
dGltZXJfaW50ZXJ2YWxfbXMpOzwvcD48cD4rPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5yZXR1cm4gc3lzZnNfZW1pdChwYWdlLCAiJWRcbiIsIHBtdS0mZ3Q7aHJ0aW1lcl9p
bnRlcnZhbF9tcyk7PC9wPjxwPiZuYnNwO308L3A+PHA+Jm5ic3A7PC9wPjxwPiZuYnNwO3N0YXRp
YyBERUZJTkVfTVVURVgobXV4X2ludGVydmFsX211dGV4KTs8L3A+PHA+LS0mbmJzcDs8L3A+PHA+
Mi4yNS4xPC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xp
u5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0cHg7Zm9u
dC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAgc3R5bGU9
ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQgWWFIZWk7
Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7ova/pm4Xp
u5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--

