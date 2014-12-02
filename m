From: William Cohen <wcohen@redhat.com>
Subject: Perf support for interpreted and Just-In-Time translated languages
Date: Tue, 02 Dec 2014 16:08:15 -0500
Message-ID: <547E2A3F.60504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53525 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365AbaLBVIQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Dec 2014 16:08:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sB2L8GOm023881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Tue, 2 Dec 2014 16:08:16 -0500
Received: from [10.13.129.109] (dhcp129-109.rdu.redhat.com [10.13.129.109])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sB2L8F2E006498
	for <linux-perf-users@vger.kernel.org>; Tue, 2 Dec 2014 16:08:16 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

perf makes use of the debug information provided by the compilers to
map the addresses observed in the instruction pointer and on the stack
back to source code.  This works very well for traditional compiled
programs written in c and c++.  However, the assumption that the
instruction address maps back to something the user wrote is not true
for code written in interpretered languages such as python, perl, and
Ruby or for Just-In-Time (JIT) runtime environment commonly used for
Java.  The addresses would either map back to the interpreter runtime
or dynamically generated code.  It would be really nice if perf was
enhanced to provide data about where in the interpreted and JIT'ed
code the processor was spending time.

OProfile provides the ability to map samples from Java Runtime
Environment (JRE) JIT code using a shared library agent loaded when
the program starts executing.  The shared library uses the JVMTI or
JVMPI interface to note the method that each region of JIT'ed code
maps to.  This is later used to map the instruction pointer back to
the appropriate Java method.  There is some information on how this is
implement at http://oprofile.sourceforge.net/doc/devel/index.html.

For traditional interpreters the samples perf get mapped to the
internals of the interpreter.  Rather than getting samples that map
back to the developer's Ruby code, developers get samples that map
back to the internals of the Ruby intpreter which they have little
control and understanding of.  What would be desired is for each
memory map region or process to have something that indicates what
kind of information perf should record for a sample in that region or
process.  By default this would fall back on the traditional IP
sampling, but allow some user-space memory locations to be read for a
line number and dcookie for the file that the code came from instead.

-Will
