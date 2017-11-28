From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Question to perf annotate handling mov ...(%rip) instructions
Date: Tue, 28 Nov 2017 11:42:16 +0100
Message-ID: <f241fe0b-7a3f-cb6a-51ee-4833bce81e70@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932462AbdK1KmW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 05:42:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vASAdNIl060132
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2017 05:42:22 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eh45c645m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2017 05:42:21 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 28 Nov 2017 10:42:20 -0000
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

I am confused by perf annotate internals.

Perf annotate examines a perf.data file and shows disassembler output.
However the output differs depending on the output option specified:

‑‑stdio: Output to stdout, also selected implicitly when output piped to another
process or redirected to a file. The function call sequence is 

symbol__tty_annotate() –> symbol__annotate_printf() –> disasm_line__print().

This output style does not annotate the branch instructions nor does it use special 
printing functions in the util/annotate.c, for example mov__scnprintf().

‑‑tui: Default. there are annotations to augment branches, jumps, fct returns 
with arrows for interactive usage. The function call stack starts with 
symbol__tui_annotate(). 
There is also special treatment for the Intel mov instructions of the form:

00000000000060b0 <_init@@Base>: 
.... 
60b4:       48 8b 05 35 cd 22 00    mov 0x22cd35(%rip),%rax   # 232df0 <__gmon_start__>     

Commit 6de783b6f50f7f1db18a3fda0aa34b2e84b5771d ("perf annotate: Resolve symbols 
using objdump comment") added this support.

Special code for Intel platform handles the mov  at address 60b4: 
This is dynamic linkage against the PLT. Function mov__parse() is always called 
to parse the objdump comment following the '#' character. 
However the function mov__scnprintf() to replace the text '0x22cd35(%rip)' by the 
target function name __gmon_start__ is only called in tui mode and not in stdio mode.

Now to the confusion:
Function mov__parse() calls comment__symbol() which contains:

   static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
   {
        char *endptr, *name, *t;

        if (strstr(raw, "(%rip)") == NULL)
                return 0;

This is architecture specific and does not work for non-Intel platforms.

I would like to fix perf annotate for s390x and above move instruction on s390x
is
     
    655a:       c0 10 00 01 9c eb       larl    %r1,39f30 <__gmon_start__>

There is a need to handle PLT resolution in an architecture independent way.

Ideas and suggestions?

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
