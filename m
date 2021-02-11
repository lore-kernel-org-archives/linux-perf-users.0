Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9389CC433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F5A64DAD
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhBKRSz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhBKRQv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Feb 2021 12:16:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D168B64E79;
        Thu, 11 Feb 2021 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613063770;
        bh=VaIx6IvZm6VH98H871KHDu2PYucjo1wXQmqEwyl7X+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ezp9ZCB8NFj5WgONBXcoUBgrJbAcu4SEk6zV7B1f2bHP5ystUc8dy1lZzktli7mMT
         KkeiKxzZwxmGKQfSjsbkm8ootBZM5kX8Y98SMJpbO2z8ZXLbUIxuvp/sc7IIzW/H0M
         QdP03iyotr6iu7j+gFtU33VFoqXmwpoNJviASQsSqbxvoRYq1LVw9g7rnMFPWdSU4F
         VIxezvPpMJdZErcjg7rDCPQUT+VBgrkWmBrRpEnQt2qRNVI0TVUGCKMs32W+u9MjFx
         3iuHFLBQjWxNRMuaHdjssz6PdrQ37CYduz8smwGE9P4ROG/+tG2Mc1+9LKnAdOtyej
         qufVS3LDNf6AA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9C0240513; Thu, 11 Feb 2021 14:16:06 -0300 (-03)
Date:   Thu, 11 Feb 2021 14:16:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] Fix jump parsing for C++ code.
Message-ID: <20210211171606.GG1131885@kernel.org>
References: <13e1a405-edf9-e4c2-4327-a9b454353730@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13e1a405-edf9-e4c2-4327-a9b454353730@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Feb 11, 2021 at 01:37:55PM +0100, Martin Liška escreveu:
> Considering the following testcase:
> 
> int
> foo(int a, int b)
> {
>   for (unsigned i = 0; i < 1000000000; i++)
>     a += b;
>   return a;
> }
> 
> int main()
> {
>   foo (3, 4);
>   return 0;
> }
> 
> perf annotate displays:
>  86.52 │40055e: → ja   40056c <foo(int, int)+0x26>
>  13.37 │400560:   mov  -0x18(%rbp),%eax
>        │400563:   add  %eax,-0x14(%rbp)
>        │400566:   addl $0x1,-0x4(%rbp)
>   0.11 │40056a: → jmp  400557 <foo(int, int)+0x11>
>        │40056c:   mov  -0x14(%rbp),%eax
>        │40056f:   pop  %rbp
> 
> and the 'ja 40056c' does not link to the location in the function.
> It's caused by fact that comma is wrongly parsed, it's part
> of function signature.
> 
> With my patch I see:
> 
>  86.52 │   ┌──ja   26
>  13.37 │   │  mov  -0x18(%rbp),%eax
>        │   │  add  %eax,-0x14(%rbp)
>        │   │  addl $0x1,-0x4(%rbp)
>   0.11 │   │↑ jmp  11
>        │26:└─→mov  -0x14(%rbp),%eax
> 
> and 'o' output prints:
>  86.52 │4005┌── ↓ ja   40056c <foo(int, int)+0x26>
>  13.37 │4005│0:   mov  -0x18(%rbp),%eax
>        │4005│3:   add  %eax,-0x14(%rbp)
>        │4005│6:   addl $0x1,-0x4(%rbp)
>   0.11 │4005│a: ↑ jmp  400557 <foo(int, int)+0x11>
>        │4005└─→   mov  -0x14(%rbp),%eax

So, before your patch, this is what I am seeing:

  [acme@five c]$ cat cpp_args_annotate.c
  int
  foo(int a, int b)
  {
     for (unsigned i = 0; i < 1000000000; i++)
       a += b;
     return a;
  }
  
  int main()
  {
     foo (3, 4);
     return 0;
  }
  [acme@five c]$ gcc --version |& head -1
  gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9)
  [acme@five c]$ gcc -g cpp_args_annotate.c -o cpp_args_annotate
  [acme@five c]$ perf record ./cpp_args_annotate
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.275 MB perf.data (7188 samples) ]
  [acme@five c]$ perf annotate --stdio2 foo
  Samples: 7K of event 'cycles:u', 4000 Hz, Event count (approx.): 7468429289, [percent: local period]
  foo() /home/acme/c/cpp_args_annotate
  Percent
              0000000000401106 <foo>:
              foo():
              int
              foo(int a, int b)
              {
                push %rbp
                mov  %rsp,%rbp
                mov  %edi,-0x14(%rbp)
                mov  %esi,-0x18(%rbp)
              for (unsigned i = 0; i < 1000000000; i++)
                movl $0x0,-0x4(%rbp)
              ↓ jmp  1d
              a += b;
   13.45  13:   mov  -0x18(%rbp),%eax
                add  %eax,-0x14(%rbp)
              for (unsigned i = 0; i < 1000000000; i++)
                addl $0x1,-0x4(%rbp)
    0.09  1d:   cmpl $0x3b9ac9ff,-0x4(%rbp)
   86.46      ↑ jbe  13
              return a;
                mov  -0x14(%rbp),%eax
              }
                pop  %rbp
              ← retq
  [acme@five c]$


Ok, now I see:

[acme@five c]$ g++ -g cpp_args_annotate.c -o cpp_args_annotate
[acme@five c]$ perf record ./cpp_args_annotate
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.268 MB perf.data (6976 samples) ]
[acme@five c]$ perf annotate --stdio2 foo
Samples: 6K of event 'cycles:u', 4000 Hz, Event count (approx.): 7380681761, [percent: local period]
foo() /home/acme/c/cpp_args_annotate
Percent
            0000000000401106 <foo(int, int)>:
            foo(int, int):
            int
            foo(int a, int b)
            {
              push %rbp
              mov  %rsp,%rbp
              mov  %edi,-0x14(%rbp)
              mov  %esi,-0x18(%rbp)
            for (unsigned i = 0; i < 1000000000; i++)
              movl $0x0,-0x4(%rbp)
              cmpl $0x3b9ac9ff,-0x4(%rbp)
 86.53      → ja   40112c <foo(int, int)+0x26>
            a += b;
 13.32        mov  -0x18(%rbp),%eax
  0.00        add  %eax,-0x14(%rbp)
            for (unsigned i = 0; i < 1000000000; i++)
              addl $0x1,-0x4(%rbp)
  0.15      → jmp  401117 <foo(int, int)+0x11>
            return a;
              mov  -0x14(%rbp),%eax
            }
              pop  %rbp
            ← retq
[acme@five c]$
  
Ok, continuing the test...

- Arnaldo
