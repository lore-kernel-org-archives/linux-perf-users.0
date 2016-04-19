From: David Ahern <dsahern@gmail.com>
Subject: Re: Missing stack symbols with perf_event's perf report, despite
 -fno-omit-frame-pointer compilation
Date: Mon, 18 Apr 2016 18:18:45 -0600
Message-ID: <57157965.4020506@gmail.com>
References: <loom.20160419T015612-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34691 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbcDSASr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2016 20:18:47 -0400
Received: by mail-io0-f179.google.com with SMTP id 2so3278014ioy.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Apr 2016 17:18:47 -0700 (PDT)
In-Reply-To: <loom.20160419T015612-712@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mark Davis <markdavisinboston@gmail.com>, linux-perf-users@vger.kernel.org

On 4/18/16 6:07 PM, Mark Davis wrote:
>     Auto-detecting system features:
>      ...                     backtrace: [ on  ]
>      ...                         dwarf: [ OFF ]
>      ...                fortify-source: [ on  ]
>      ...                         glibc: [ on  ]
>      ...                          gtk2: [ on  ]
>      ...                  gtk2-infobar: [ on  ]
>      ...                      libaudit: [ OFF ]
>      ...                        libbfd: [ OFF ]
>      ...                        libelf: [ OFF ]

Install those 2 development packages.
