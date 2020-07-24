From: Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [PATCH -next] tools lib traceevent: Remove process in finding plugin options
Date: Fri, 24 Jul 2020 17:59:57 +0800
Message-ID: <20200724095957.48159-1-bobo.shaobowang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: cj.chengjian@huawei.com, huawei.libin@huawei.com, rostedt@goodmis.org, acme@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

In function load_plugin, we get symbol loaded address from symbol name
TEP_PLUGIN_LOADER_NAME, whereas the symbol name TEP_PLUGIN_ALIAS_NAME
is optionally used for finding plugin options which is not used after.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/lib/traceevent/event-plugin.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index e1f7ddd5a6cf..c6435087b5b6 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -275,7 +275,6 @@ load_plugin(struct tep_handle *tep, const char *path,
 	struct tep_plugin_list **plugin_list = data;
 	tep_plugin_load_func func;
 	struct tep_plugin_list *list;
-	const char *alias;
 	char *plugin;
 	void *handle;
 	int ret;
@@ -293,10 +292,6 @@ load_plugin(struct tep_handle *tep, const char *path,
 		goto out_free;
 	}
 
-	alias = dlsym(handle, TEP_PLUGIN_ALIAS_NAME);
-	if (!alias)
-		alias = file;
-
 	func = dlsym(handle, TEP_PLUGIN_LOADER_NAME);
 	if (!func) {
 		warning("could not find func '%s' in plugin '%s'\n%s\n",
-- 
2.17.1
