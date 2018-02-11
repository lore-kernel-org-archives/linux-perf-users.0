From: Martin Vuille <jpmv27@aim.com>
Subject: [RFC PATCH 0/1] perf annotate: Don't prepend symfs path to vmlinux path
Date: Sun, 11 Feb 2018 15:32:09 -0500
Message-ID: <20180211203210.12738-1-jpmv27@aim.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from omr-m016e.mx.aol.com ([204.29.186.16]:36930 "EHLO
        omr-m016e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbeBKUcZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Feb 2018 15:32:25 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

This fix works for my use case of supplying both '--symfs' and '--vmlinux'
options, and should be harmless if '--symfs' is not specified, but I suspect
it could cause problems if '--symfs' is specified without '--vmlinux', as
the symfs path will no longer be prepended and vmlinux may no longer be found.

Would appreciate any insights on a better approach to fix fix the issue.

Regards,
MV
