Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B4C4321E
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Nov 2022 13:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiK0NBX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Nov 2022 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiK0NBU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Nov 2022 08:01:20 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80C25B49B;
        Sun, 27 Nov 2022 05:01:19 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 27 Nov
 2022 21:00:33 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.36]
Date:   Sun, 27 Nov 2022 21:00:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] perf/x86/amd/lbr:convert sysfs snprintf to sysfs_emit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <228a1b59.1d5.184b92cd4b9.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXn+ByX4NjpXIFAA--.100W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQADB2FEYx0G1gAIsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKYXJjaC94ODYvZXZlbnRzL2Ft
ZC9jb3JlLmM6MTI3Njo4LTE2OiBXQVJOSU5HOiB1c2Ugc2NucHJpbnRmIG9yIHNwcmludGYKClNp
Z25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBhcmNo
L3g4Ni9ldmVudHMvYW1kL2NvcmUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29y
ZS5jIGIvYXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMKaW5kZXggZDZmMzcwM2U0MTE5Li41ZGIz
ODRmNmNhNGMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jCisrKyBiL2Fy
Y2gveDg2L2V2ZW50cy9hbWQvY29yZS5jCkBAIC0xMjcyLDcgKzEyNzIsNyBAQCBzdGF0aWMgc3Np
emVfdCBicmFuY2hlc19zaG93KHN0cnVjdCBkZXZpY2UgKmNkZXYsCiAJCQkgICAgICBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKIAkJCSAgICAgIGNoYXIgKmJ1ZikKIHsKLQlyZXR1cm4g
c25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlZFxuIiwgeDg2X3BtdS5sYnJfbnIpOworCXJldHVy
biBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCB4ODZfcG11Lmxicl9ucik7CiB9CiAKIHN0YXRpYyBE
RVZJQ0VfQVRUUl9STyhicmFuY2hlcyk7Ci0tIAoyLjI1LjEK
