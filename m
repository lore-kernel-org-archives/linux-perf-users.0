From: HOUSSEN Franck <fghoussen@gmail.com>
Subject: Can not trace perf-probe event (made to probe the main function) with perf-top
Date: Sat, 19 Nov 2016 17:36:39 +0100
Message-ID: <CABvthiqxj=FCj-hg1Bhdnx=sTMZVt78nAM_N89HuuzfkBf7ZJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114b2d26eb324d0541aa06d7
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38830 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750958AbcKSQgl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 19 Nov 2016 11:36:41 -0500
Received: by mail-wm0-f48.google.com with SMTP id f82so81243706wmf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Nov 2016 08:36:40 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--001a114b2d26eb324d0541aa06d7
Content-Type: text/plain; charset=UTF-8

Can not trace perf-probe event (made to probe the main function) with
perf-top ? (see ReadMe.txt - works with perf-report and -s option)
Can someone help ? Missing option ? Known bug / limitation ?

Thanks,

Franck

--001a114b2d26eb324d0541aa06d7
Content-Type: text/plain; charset=US-ASCII; name="ReadMe.txt"
Content-Disposition: attachment; filename="ReadMe.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivpfsf050

L3RtcD4gbW9yZSBtYWluLmNwcAojaW5jbHVkZSA8dW5pc3RkLmg+IC8vIHNsZWVwCmludCBtYWlu
KHZvaWQpIHsgc2xlZXAoMTApOyByZXR1cm4gMDsgfQoKL3RtcD4gZ2NjIC1nIG1haW4uY3BwIC1v
IG1haW4KCi90bXA+IHN1ZG8gcGVyZiBwcm9iZSAtLWV4ZWMgLi9tYWluIC0tYWRkIG1haW4KQWRk
ZWQgbmV3IGV2ZW50OgogIHByb2JlX21haW46bWFpbiAgICAgIChvbiBtYWluIGluIC90bXAvbWFp
bikKICBZb3UgY2FuIG5vdyB1c2UgaXQgaW4gYWxsIHBlcmYgdG9vbHMsIHN1Y2ggYXM6CiAgICBw
ZXJmIHJlY29yZCAtZSBwcm9iZV9tYWluOm1haW4gLWFSIHNsZWVwIDEKCi90bXA+IHN1ZG8gcGVy
ZiByZWNvcmQgLWUgcHJvYmVfbWFpbjptYWluIC4vbWFpbgpbIHBlcmYgcmVjb3JkOiBXb2tlbiB1
cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQpbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3Jv
dGUgMC4wMTcgTUIgcGVyZi5kYXRhICgxIHNhbXBsZXMpIF0KCi90bXA+IHN1ZG8gcGVyZiByZXBv
cnQgLS1zdGRpbyAtcyBzeW0sZHNvCiMgVG8gZGlzcGxheSB0aGUgcGVyZi5kYXRhIGhlYWRlciBp
bmZvLCBwbGVhc2UgdXNlIC0taGVhZGVyLy0taGVhZGVyLW9ubHkgb3B0aW9ucy4KIwojCiMgVG90
YWwgTG9zdCBTYW1wbGVzOiAwCiMKIyBTYW1wbGVzOiAxICBvZiBldmVudCAncHJvYmVfbWFpbjpt
YWluJwojIEV2ZW50IGNvdW50IChhcHByb3guKTogMQojCiMgT3ZlcmhlYWQgIFRyYWNlIG91dHB1
dAojIC4uLi4uLi4uICAuLi4uLi4uLi4uLi4KIwogICAxMDAuMDAlICBtYWluCiMKIyAoVGlwOiBM
aXN0IGV2ZW50cyB1c2luZyBzdWJzdHJpbmcgbWF0Y2g6IHBlcmYgbGlzdCA8a2V5d29yZD4pCiMK
Cn4+IHN1ZG8gcGVyZiB0b3AgLUsgLS1zdGRpbyAtcyBzeW0sZHNvIC1lIHByb2JlX21haW46bWFp
bgogICBQZXJmVG9wOiAgICAgICAwIGlycXMvc2VjICBrZXJuZWw6IDAuMCUgIGV4YWN0OiAgMC4w
JSBbMUh6IHByb2JlX21haW46bWFpbl0sICAoYWxsLCA0IENQVXMpCiAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KCn4+IGxzYl9yZWxlYXNlIC1hCk5vIExTQiBtb2R1bGVzIGFy
ZSBhdmFpbGFibGUuCkRpc3RyaWJ1dG9yIElEOiBEZWJpYW4KRGVzY3JpcHRpb246ICBEZWJpYW4g
R05VL0xpbnV4IHRlc3RpbmcgKHN0cmV0Y2gpClJlbGVhc2U6ICB0ZXN0aW5nCkNvZGVuYW1lOiBz
dHJldGNoCgp+PiBjYXQgL3Byb2Mvc3lzL2tlcm5lbC9wZXJmX2V2ZW50X3BhcmFub2lkCi0xCgp+
PiBjYXQgL3Byb2Mvc3lzL2tlcm5lbC9rcHRyX3Jlc3RyaWN0CjAKCn4+IGdjYyAtLXZlcnNpb24K
Z2NjIChEZWJpYW4gNi4yLjAtMTApIDYuMi4wIDIwMTYxMDI3Cgp+PiBwZXJmIC0tdmVyc2lvbgpw
ZXJmIHZlcnNpb24gNC43LjgKCn4+IHVuYW1lIC1hCkxpbnV4IHlvZGEgNC43LjAtMS1hbWQ2NCAj
MSBTTVAgRGViaWFuIDQuNy44LTEgKDIwMTYtMTAtMTkpIHg4Nl82NCBHTlUvTGludXgKCg==
--001a114b2d26eb324d0541aa06d7--
