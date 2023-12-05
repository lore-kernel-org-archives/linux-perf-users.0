Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="eepNSnhW"
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B78DD3
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=OaeCLpe3jOeLZzJSrVCinBmndrE3oSCGS5scTqTfFdU=; b=eepNSnhW2FPuP
	jNWBUFOkG1B7OGwe4KNgSPhR8mWCZRgoVCvmwAg7KwXkbV85zgJOOvQp3t33xPPl
	DLMrAn0EYASdjB2aPhZQSaN04vk39nJCAJ1llifTLWmX30PozhcE82HO+mjsNjdm
	nOWwaH74iltPrtiRAslfnfDlfblQlk=
Received: from chang-liu22$mails.tsinghua.edu.cn ( [183.172.79.243] ) by
 ajax-webmail-web2 (Coremail) ; Wed, 6 Dec 2023 00:00:59 +0800 (GMT+08:00)
Date: Wed, 6 Dec 2023 00:00:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chang-liu22@mails.tsinghua.edu.cn
To: linux-perf-users@vger.kernel.org
Subject: Can I create and read perf counters in the kernel?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230915(bf90896b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df55a87-4b50-4a66-85a0-70f79cb6c8b5-tsinghua.edu.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3ac77391.1d70f.18c3ab61090.Coremail.chang-liu22@mails.tsinghua.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yQQGZQA3mWI7SW9ldH+wAg--.39274W
X-CM-SenderInfo: xfkd0wonol3j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAQEQAGVu
	Wi+9dQABsn
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgYWxsLAoKSSdtIGRvaW5nIGEgcmVzZWFyY2ggcHJvamVjdCBpbiB3aGljaCBJIGltcGxlbWVu
dCBhIG5ldyBmdW5jdGlvbmFsaXR5IGluIHRoZSBrZXJuZWwuIE5vdyBJIHdhbnQgdG8gYmVuY2ht
YXJrIHRoZSBjb2RlIHRoYXQgSSB3cml0ZSwgZS5nLiwgSSB3YW50IHRvIG1lYXN1cmUgdGhlIG51
bWJlciBvZiBjYWNoZSBtaXNzZXMgb2YgbXkgY29kZSB3aXRoIGRpZmZlcmVudCB3b3JrbG9hZHMu
IEkgd29uZGVyIGlmIEkgY291bGQgY3JlYXRlIHBlcmYgY291bnRlcnMgYW5kIHJlYWQgdGhlbSBp
biBrZXJuZWwganVzdCBsaWtlIHVzaW5nIHBlcmZfZXZlbnRfb3BlbigpICsgcmVhZCgpIGluIHVz
ZXIgc3BhY2UgdG8gaW1wbGVtZW50IHRoZSBmb2xsb3dpbmcgbG9naWM6Ci0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KY3JhdGVfcGVyZl9jb3VudGVyKCkKCnJlc2V0X2FuZF9zdGFydF9j
b3VudGVyKCkKcnVuIHNvbWUga2VybmVsIGNvZGUKcmVhZF9jb3VudGVyKCkKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpJZiBJIGNhbiwgd2hhdCBrZXJuZWwgQVBJIHNob3VsZCBJIHVz
ZT8gSXMgdGhlcmUgYW55IGRvY3VtZW50IHRoYXQgSSBjYW4gcmVmZXI/CgpJJ2QgYmUgdmVyeSBn
cmF0ZWZ1bCBpZiBhbnlvbmUgY2FuIGhlbHAgOikKCktpbmQgcmVnYXJkcywKCkNoYW5nIExpdSA=

