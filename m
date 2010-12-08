From: David Ahern <daahern@cisco.com>
Subject: [PATCH 0/2] perf tools: add reference timestamp and use it in time history dump
Date: Tue,  7 Dec 2010 18:54:43 -0700
Message-ID: <1291773285-16254-1-git-send-email-daahern@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Ahern <daahern@cisco.com>
List-Id: linux-perf-users.vger.kernel.org

David Ahern (2):
  perf tools: Add reference timestamp to perf header
  perf tools: Add option to show time history of event samples

 tools/perf/builtin-record.c |    8 +++
 tools/perf/builtin-report.c |  131 ++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.c    |   51 +++++++++++++++++
 tools/perf/util/header.h    |    3 +
 tools/perf/util/session.c   |   26 +++++++++
 5 files changed, 217 insertions(+), 2 deletions(-)

-- 
1.7.2.3
