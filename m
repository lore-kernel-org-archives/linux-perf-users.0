From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf buildid-list: Show running kernel build id fix
Date: Fri, 27 Nov 2015 14:48:03 +0100
Message-ID: <1448632083.24573.113.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47913 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbbK0NsH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Nov 2015 08:48:07 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= / =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

I have noticed that the '--kernel' option of perf buildid-list
tool has been broken, so no buildid is printed.

The attached patch should address the issue.

I have tested it against the latest version of Linus' tree.
Nothing wrong should be caused by this change, since in the
other cases when the function is called, no one cares about
the return value.

Michael


Michael Petlan (1):
  perf buildid-list: Show running kernel build id fix

 tools/perf/util/build-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
