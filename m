From: Jerome Correnoz <jerome.correnoz@st.com>
Subject: Is it possible to get source code annotation for kernel modules ?
Date: Wed, 26 Nov 2014 21:05:23 +0000 (UTC)
Message-ID: <loom.20141126T215923-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55544 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaKZVFi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 16:05:38 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XtjmI-00047H-Ia
	for linux-perf-users@vger.kernel.org; Wed, 26 Nov 2014 22:05:34 +0100
Received: from 77.242.202.243 ([77.242.202.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2014 22:05:34 +0100
Received: from jerome.correnoz by 77.242.202.243 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2014 22:05:34 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

With 'pref annotate', when compiling a user space application with '-
ggdb', we successfully display C source code interleaved with disassembly.

ercent |      Source code & Disassembly of dvbtest
------------------------------------------------
         :
         :
         :
         :      Disassembly of section .text:
         :
         :      00029c2c <PutBits>:
         :      }
         :      /*}}}*/
         :
         :      /*{{{  PutBits functions*/
         :      void PutBits(BitPacker_t *ld, unsigned int code, unsigned 
int length)
         :      {
   16.67 :         29c2c:       push    {fp}            ; (str fp, [sp, #-
4]!)
    0.00 :         29c30:       add     fp, sp, #0
    0.00 :         29c34:       sub     sp, sp, #28
    0.00 :         29c38:       str     r0, [fp, #-16]
    0.00 :         29c3c:       str     r1, [fp, #-20]
    0.00 :         29c40:       str     r2, [fp, #-24]
         :          unsigned int bit_buf;
         :          int bit_left;
         :
         :          bit_buf = ld->BitBuffer;
    0.00 :         29c44:       ldr     r3, [fp, #-16]
    0.00 :         29c48:       ldr     r3, [r3, #4]
    0.00 :         29c4c:       str     r3, [fp, #-8]
         :          bit_left = ld->Remaining;
    0.00 :         29c50:       ldr     r3, [fp, #-16]
    0.00 :         29c54:       ldr     r3, [r3, #8]
    0.00 :         29c58:       str     r3, [fp, #-12]
         :              DVBTEST_TRACE("code = %d, length = %d, bit_buf = 
0x%x, bit_left = %d\n", code, length, bit_buf, bit_left);
         :          }


We would like to know if possible for kernel module to get the source code 
interleaved with disassembly ? For time being, we only have disassembly 
with annotation. It would be very useful if we could have C source code 
annotation for kernel module.

Regards,
  Jerome
