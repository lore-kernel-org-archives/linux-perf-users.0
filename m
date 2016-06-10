From: Brian Robbins <brianrob@microsoft.com>
Subject: C++ Demangling in Perf Backtraces
Date: Fri, 10 Jun 2016 23:08:03 +0000
Message-ID: <CO2PR00MB00855E5836D39D8CA5A49B3FC8500@CO2PR00MB0085.namprd00.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-by2on0113.outbound.protection.outlook.com ([207.46.100.113]:61509
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751918AbcFJXi5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jun 2016 19:38:57 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

When using perf to collect data with backtraces, I've noticed that none of the C++ symbols in our binaries get de-mangled properly, so they end up looking like these:

	_ZN18MethodDescCallSite16CallTargetWorkerEPKm
	_ZNK10SigPointer24PeekValueTypeTokenClosedEP6ModulePK14SigTypeContextPS1_
	_ZL31ManagedThreadBase_DispatchOuterP22ManagedThreadCallState
	_ZN17ManagedThreadBase10ThreadPoolE4ADIDPFvPvES1_
	_Z23CopyValueClassUncheckedPvS_P11MethodTable
	_ZN13ThreadpoolMgr17WorkerThreadStartEPv
	_ZN11ClassLoader24LoadApproxParentThrowingEP6ModulejP10SigPointerPK14SigTypeContext

If I debug the same application with the same binaries using lldb for example, the symbols get demangled properly.

Are there any known issues or pitfalls that I might be encountering here?

I've tried various versions perf - the latest that I've tried is: perf version 4.2.8-ckt1

Thanks in advance,
-Brian
