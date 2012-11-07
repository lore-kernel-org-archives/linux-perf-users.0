From: Florin Trofin <ftrofin@adobe.com>
Subject: perf: 'archive' is not a perf-command
Date: Wed, 7 Nov 2012 13:23:17 -0800
Message-ID: <CCC01133.6EA9%ftrofin@adobe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:46575 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2KGVaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 7 Nov 2012 16:30:03 -0500
Received: from inner-relay-4.eur.adobe.com (inner-relay-4b [10.128.4.237])
	by outbound-smtp-2.corp.adobe.com (8.12.10/8.12.10) with ESMTP id qA7LNKHP029715
	for <linux-perf-users@vger.kernel.org>; Wed, 7 Nov 2012 13:23:20 -0800 (PST)
Received: from nacas03.corp.adobe.com (nacas03.corp.adobe.com [10.8.189.121])
	by inner-relay-4.eur.adobe.com (8.12.10/8.12.9) with ESMTP id qA7LNIXM020636
	for <linux-perf-users@vger.kernel.org>; Wed, 7 Nov 2012 13:23:20 -0800 (PST)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

I am experimenting with the performance tools on Ubuntu 12.04 and I am
getting this weird error. Here is the environment:

$ perf --version
perf version 3.2.30

$perf archive
perf: 'archive' is not a perf-command. See 'perf --help'.

$perf --help

 usage: perf [--version] [--help] COMMAND [ARGS]

 The most commonly used perf commands are:
   annotate        Read perf.data (created by perf record) and display
annotated code
   archive         Create archive with object files with build-ids found
in perf.data file
   bench           General framework for benchmark suites
   ...

Is this a known bug in this version? Older versions seem to recognize the
archive command.

Thanks!

Florin
