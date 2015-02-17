From: taeung <treeze.taeung@gmail.com>
Subject: perfconfig : what does mean annotate.show_nr_jumps ?
Date: Tue, 17 Feb 2015 19:07:40 +0900
Message-ID: <54E312EC.7010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46015 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbBQKHs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Feb 2015 05:07:48 -0500
Received: by pdjz10 with SMTP id z10so42690359pdj.12
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2015 02:07:47 -0800 (PST)
Received: from [123.140.74.165] ([123.140.74.165])
        by mx.google.com with ESMTPSA id ph7sm17149394pbb.6.2015.02.17.02.07.46
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2015 02:07:46 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, list

what does mean annotate.show_nr_jumps ?


If I configure 'annotate.show_nr_jumps' with a boolean 'false'
The output is as below..

         =E2=94=821382:   movb   $0x1,-0x270(%rbp)
         =E2=94=82          =E2=86=91 jmpq   1223
         =E2=94=82            xchg   %ax,%ax
3.51 =E2=94=821390:   mov    -0x210(%rbp),%rax
         =E2=94=82            movslq %r15d,%rsi
         =E2=94=82            mov    0x68(%rax),%rax
         =E2=94=82            testb  $0x10,0x1(%rax,%rsi,2)
7.89 =E2=94=82         =E2=86=91 je     be6
2.63 =E2=94=8213a9:   mov    %r9,%rbx

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

And If I set 'true' to it, the output is as below

         =E2=94=82    1 1382:   movb   $0x1,-0x270(%rbp)
         =E2=94=82                 =E2=86=91 jmpq   1223
         =E2=94=82                   xchg   %ax,%ax
3.51 =E2=94=82    1 1390:   mov    -0x210(%rbp),%rax
         =E2=94=82                   movslq %r15d,%rsi
         =E2=94=82                   mov    0x68(%rax),%rax
         =E2=94=82                   testb  $0x10,0x1(%rax,%rsi,2)
7.89 =E2=94=82                 =E2=86=91 je     be6
2.63 =E2=94=82    1 13a9:   mov    %r9,%rbx

What does mean the number '1' in front of address such as  " 1 13a9: " =
?


Thanks,
Taeung
